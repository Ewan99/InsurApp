package main

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
      currency             string `json:"currency"`
    }

// InitLedger adds a base set of assets to the ledger
   func (s *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface) error {
    assets := []Asset{
      {Currency: "Euro"},
    }

    for _, asset := range assets {
      assetJSON, err := json.Marshal(asset)
      if err != nil {
        return err
      }

      err = ctx.GetStub().PutState(asset.currency, assetJSON)
      if err != nil {
        return fmt.Errorf("failed to put to world state. %v", err)
      }
    }

    return nil
  }

// CreateAsset issues a new asset to the world state with given details.
   func (s *SmartContract) CreateAsset(ctx contractapi.TransactionContextInterface, currency string) error {
    exists, err := s.AssetExists(ctx, currency)
    if err != nil {
      return err
    }
    if exists {
      return fmt.Errorf("the asset %s already exists", currency)
    }

    asset := Asset{
      Currency:             currency,
    }
    assetJSON, err := json.Marshal(asset)
    if err != nil {
      return err
    }

    return ctx.GetStub().PutState(currency, assetJSON)
  }

// ReadAsset returns the asset stored in the world state with given currency.
   func (s *SmartContract) ReadAsset(ctx contractapi.TransactionContextInterface, currency string) (*Asset, error) {
    assetJSON, err := ctx.GetStub().GetState(currency)
    if err != nil {
      return nil, fmt.Errorf("failed to read from world state: %v", err)
    }
    if assetJSON == nil {
      return nil, fmt.Errorf("the asset %s does not exist", currency)
    }

    var asset Asset
    err = json.Unmarshal(assetJSON, &asset)
    if err != nil {
      return nil, err
    }

    return &asset, nil
  }

// UpdateAsset updates an existing asset in the world state with provided parameters.
   func (s *SmartContract) UpdateAsset(ctx contractapi.TransactionContextInterface, currency string) error {
    exists, err := s.AssetExists(ctx, currency)
    if err != nil {
      return err
    }
    if !exists {
      return fmt.Errorf("the asset %s does not exist", currency)
    }

    // overwriting original asset with new asset
    asset := Asset{
      currency:             currency,
    }
    assetJSON, err := json.Marshal(asset)
    if err != nil {
      return err
    }

    return ctx.GetStub().PutState(currency, assetJSON)
  }

  // DeleteAsset deletes an given asset from the world state.
  func (s *SmartContract) DeleteAsset(ctx contractapi.TransactionContextInterface, currency string) error {
    exists, err := s.AssetExists(ctx, currency)
    if err != nil {
      return err
    }
    if !exists {
      return fmt.Errorf("the asset %s does not exist", currency)
    }

    return ctx.GetStub().DelState(currency)
  }

// AssetExists returns true when asset with given currency exists in world state
   func (s *SmartContract) AssetExists(ctx contractapi.TransactionContextInterface, currency string) (bool, error) {
    assetJSON, err := ctx.GetStub().GetState(currency)
    if err != nil {
      return false, fmt.Errorf("failed to read from world state: %v", err)
    }

    return assetJSON != nil, nil
  }

// TransferAsset updates the owner field of asset with given currency in world state.
   func (s *SmartContract) TransferAsset(ctx contractapi.TransactionContextInterface, currency string, newOwner string, transferAmount int) error {
    asset, err := s.ReadAsset(ctx, currency)
    if err != nil {
      return err
    }

    asset.Owner = newOwner
    assetJSON, err := json.Marshal(asset)
    if err != nil {
      return err
    }

	asset.transferAmount = transferAmount
    assetJSON, err := json.Marshal(asset)
    if err != nil {
      return err
    }

    return ctx.GetStub().PutState(currency, assetJSON)
  }

// GetAllAssets returns all assets found in world state
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