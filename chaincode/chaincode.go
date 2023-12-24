package chaincode

import (
	"encoding/json"
	"fmt"
	"log"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// SmartContract provides functions for managing an Asset
type SmartContract struct {
	contractapi.Contract
}

// Asset describes basic details of what makes up a simple asset
type Asset struct {
	PID         int  `json:"pid"`
	UUID        int  `json:"uuid"`
	Vehicle     int  `json:"vehicle"`
	PolicyType  int  `json:"policytype"`
	PremiumPaid bool `json:"premiumpaid"`
}

// CreateAsset issues a new asset to the world state with given details.
func (s *SmartContract) CreateAsset(ctx contractapi.TransactionContextInterface, pid, uuid, vehicle, policytype int, premiumpaid bool) error {
	exists, err := s.AssetExists(ctx, pid)
	if err != nil {
		return err
	}
	if exists {
		return fmt.Errorf("An insurance policy for this vehicle already exists")
	}

	asset := Asset{
		PID:         pid,
		UUID:        uuid,
		Vehicle:     vehicle,
		PolicyType:  policytype,
		PremiumPaid: premiumpaid,
	}
	assetJSON, err := json.Marshal(asset)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(fmt.Sprintf("%d", pid), assetJSON)
}

// ReadAsset returns the asset stored in the world state with given id.
func (s *SmartContract) ReadAsset(ctx contractapi.TransactionContextInterface, queryid int, idType string) (*Asset, error) {
	var assetID string
	if idType == "person" {
		assetID = fmt.Sprintf("%d", queryid)
	} else if idType == "policy" {
		assetID = fmt.Sprintf("%d", queryid)
	} else {
		return nil, fmt.Errorf("Invalid idType: %s", idType)
	}

	assetJSON, err := ctx.GetStub().GetState(assetID)
	if err != nil {
		return nil, fmt.Errorf("failed to read from world state: %v", err)
	}
	if assetJSON == nil {
		return nil, fmt.Errorf("the asset %s does not exist", assetID)
	}

	var asset Asset
	err = json.Unmarshal(assetJSON, &asset)
	if err != nil {
		return nil, err
	}

	return &asset, nil
}

// UpdateAsset updates an existing asset in the world state with provided parameters.
func (s *SmartContract) UpdateAsset(ctx contractapi.TransactionContextInterface, pid int, moneyPool string) error {
	exists, err := s.AssetExists(ctx, pid)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf("This policy does not exist")
	}

	// Overwriting original asset with new asset
	asset := Asset{
		PID: pid,
		// Add other fields that you want to update
	}
	assetJSON, err := json.Marshal(asset)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(fmt.Sprintf("%d", pid), assetJSON)
}

// DeleteAsset deletes a given asset from the world state.
func (s *SmartContract) DeleteAsset(ctx contractapi.TransactionContextInterface, pid int) error {
	exists, err := s.AssetExists(ctx, pid)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf("the asset %d does not exist", pid)
	}

	return ctx.GetStub().DelState(fmt.Sprintf("%d", pid))
}

// AssetExists returns true when an asset with the given PID exists in the world state
func (s *SmartContract) AssetExists(ctx contractapi.TransactionContextInterface, pid int) (bool, error) {
	assetJSON, err := ctx.GetStub().GetState(fmt.Sprintf("%d", pid))
	if err != nil {
		return false, fmt.Errorf("failed to read from world state: %v", err)
	}

	return assetJSON != nil, nil
}

// TransferAsset updates the owner field of an asset with the given PID in the world state.
func (s *SmartContract) TransferAsset(ctx contractapi.TransactionContextInterface, pid int, newOwner string) error {
	asset, err := s.ReadAsset(ctx, pid, "policy")
	if err != nil {
		return err
	}

	// You can perform any other transfer-related logic here

	assetJSON, err := json.Marshal(asset)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(fmt.Sprintf("%d", pid), assetJSON)
}

// GetAllAssets returns all assets found in the world state
func (s *SmartContract) GetAllAssets(ctx contractapi.TransactionContextInterface) ([]*Asset, error) {
	resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
	if err != nil {
		return nil, err
	}
	defer resultsIterator.Close()

	var assets []*Asset
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return nil, err
		}

		var asset Asset
		err = json.Unmarshal(queryResponse.Value, &asset)
		if err != nil {
			return nil, err
		}
		assets = append(assets, &asset)
	}

	return assets, nil
}

func main() {
	assetChaincode, err := contractapi.NewChaincode(&SmartContract{})
	if err != nil {
		log.Panicf("Error creating asset-transfer-basic chaincode: %v", err)
	}

	if err := assetChaincode.Start(); err != nil {
		log.Panicf("Error starting asset-transfer-basic chaincode: %v", err)
	}
}