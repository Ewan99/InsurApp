package chaincode

import 
(
  "encoding/json"
  "fmt"
  "log"

  "github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// SmartContract provides functions for managing an Asset
   type SmartContract struct 
    {
      contractapi.Contract
    }

// Asset describes basic details of what makes up a simple asset
    type Asset struct 
    {
      PID             int `json:"pid"`
      UUID            int `json:"uuid"`
      Vehicle         int `json:"vehicle"`
      PolicyType      int `json:"policytype"`
      PremiumPaid      bool `json:"premiumpaid"`
    }

// CreateAsset issues a new asset to the world state with given details.
   func (s *SmartContract) CreateAsset(ctx contractapi.TransactionContextInterface, Vehicle string) error 
   {
    exists, err := s.AssetExists(ctx, Vehicle)
    if err != nil 
    {
      return err
    }
    if exists 
    {
      return fmt.Errorf("An insurance policy for this vehicle already exists")
    }

    asset := Asset
    {
      PID:            pid,
      UUID:           uuid,
      Vehicle:        vehicle,
      PolicyType:     policytype,
      PremiumPaid:    premiumpaid,
    }
    assetJSON, err := json.Marshal(asset)
    if err != nil 
    {
      return err
    }

    return ctx.GetStub().PutState(moneyPool, assetJSON)
  }

// ReadAsset returns the asset stored in the world state with given id.
   func (s *SmartContract) ReadAsset(ctx contractapi.TransactionContextInterface, queryid int, idType string) (*Asset, error) 
   {
    if idType = "person"
    {
      int queryPerson = queryid
      assetJSON, err := ctx.GetStub().GetState(queryPerson)
      if err != nil {
        return nil, fmt.Errorf("failed to read from world state: %v", err)
      }
      if assetJSON == nil {
        return nil, fmt.Errorf("the asset %s does not exist", queryid)
      }

      var asset Asset
      err = json.Unmarshal(assetJSON, &asset)
      if err != nil {
        return nil, err
      }

      return &asset, nil
    }
    else if idType = "policy"
    {
      int queryPolicy = queryid
      assetJSON, err := ctx.GetStub().GetState(queryid)
      if err != nil {
        return nil, fmt.Errorf("failed to read from world state: %v", err)
      }
      if assetJSON == nil {
        return nil, fmt.Errorf("the asset %s does not exist", queryid)
      }

      var asset Asset
      err = json.Unmarshal(assetJSON, &asset)
      if err != nil {
        return nil, err
      }

      return &asset, nil
    }

    }

// UpdateAsset updates an existing asset in the world state with provided parameters.
   func (s *SmartContract) UpdateAsset(ctx contractapi.TransactionContextInterface, moneyPool string) error {
    exists, err := s.AssetExists(ctx, moneyPool)
    if err != nil 
    {
      return err
    }
    if !exists {
      return fmt.Errorf("This policy does not exist")
    }

    // overwriting original asset with new asset
    asset := Asset
    {
      moneyPool:             moneyPool,
    }
    assetJSON, err := json.Marshal(asset)
    if err != nil 
    {
      return err
    }

    return ctx.GetStub().PutState(moneyPool, assetJSON)
  }

  // DeleteAsset deletes an given asset from the world state.
  func (s *SmartContract) DeleteAsset(ctx contractapi.TransactionContextInterface, moneyPool string) error 
  {
    exists, err := s.AssetExists(ctx, moneyPool)
    if err != nil 
    {
      return err
    }
    if !exists 
    {
      return fmt.Errorf("the asset %s does not exist", moneyPool)
    }

    return ctx.GetStub().DelState(moneyPool)
  }

// AssetExists returns true when asset with given moneyPool exists in world state
   func (s *SmartContract) AssetExists(ctx contractapi.TransactionContextInterface, moneyPool string) (bool, error) 
   {
    assetJSON, err := ctx.GetStub().GetState(moneyPool)
    if err != nil 
    {
      return false, fmt.Errorf("failed to read from world state: %v", err)
    }

    return assetJSON != nil, nil
  }

// TransferAsset updates the owner field of asset with given moneyPool in world state.
   func (s *SmartContract) TransferAsset(ctx contractapi.TransactionContextInterface, moneyPool string, newOwner string, transferAmount int) error 
   {
    asset, err := s.ReadAsset(ctx, moneyPool)
    if err != nil 
    {
      return err
    }

    asset.Owner = newOwner
    assetJSON, err := json.Marshal(asset)
    if err != nil 
    {
      return err
    }

	asset.transferAmount = transferAmount
    assetJSON, err := json.Marshal(asset)
    if err != nil 
    {
      return err
    }

    return ctx.GetStub().PutState(moneyPool, assetJSON)
  }

// GetAllAssets returns all assets found in world state
   func (s *SmartContract) GetAllAssets(ctx contractapi.TransactionContextInterface) ([]*Asset, error) 
   {
    resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
    if err != nil 
    {
      return nil, err
    }
    defer resultsIterator.Close()

    var assets []*Asset
    for resultsIterator.HasNext() 
    {
      queryResponse, err := resultsIterator.Next()
      if err != nil 
      {
        return nil, err
      }

      var asset Asset
      err = json.Unmarshal(queryResponse.Value, &asset)
      if err != nil 
      {
        return nil, err
      }
      assets = append(assets, &asset)
    }

    return assets, nil
  }

  func main() 
  {
    assetChaincode, err := contractapi.NewChaincode(&SmartContract{})
    if err != nil 
    {
      log.Panicf("Error creating asset-transfer-basic chaincode: %v", err)
    }

    if err := assetChaincode.Start(); err != nil 
    {
      log.Panicf("Error starting asset-transfer-basic chaincode: %v", err)
    }
  }