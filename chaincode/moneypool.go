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
      moneyPool             int `json:"moneypool"`
    }

// InitLedger adds a base set of assets to the ledger
   func (s *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface) error 
   {
    assets := []Asset
    {
      {moneyPool: 0},
    }

    for _, asset := range assets 
    {
      assetJSON, err := json.Marshal(asset)
      if err != nil 
      {
        return err
      }

      err = ctx.GetStub().PutState(asset.moneyPool, assetJSON)
      if err != nil 
      {
        return fmt.Errorf("failed to put to world state. %v", err)
      }
    }

    return nil
  }

// UpdateAsset updates an existing asset in the world state with provided parameters.
   func (s *SmartContract) UpdateAsset(ctx contractapi.TransactionContextInterface, moneyPool int) 
    if !exists {
      return fmt.Errorf("the asset %s does not exist", moneyPool)
    }

    // overwriting original asset with new asset
    asset := Asset
    {
      moneyPool:             moneypool,
    }
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