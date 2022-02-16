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
      CID             int `json:"CID"`
      PID             int `json:"PID"`
      Details             string `json:"Details"`
      Value             int `json:"Value"`
      Status             string `json:"Status"`
    }

// CreateAsset issues a new asset to the world state with given details.
   func (s *SmartContract) CreateAsset(ctx contractapi.TransactionContextInterface, claimID int, personID int, claimDetails string, claimValue int, claimStatus string) error 
   {
    exists, err := s.AssetExists(ctx, claimID)
    if err != nil 
    {
      return err
    }
    if exists 
    {
      return fmt.Errorf("This unique claim already exists")
    }

    asset := Asset
    {
      CID:            claimID,
      PID:            personID,
      Details:            claimDetails,
      CID:            claimValue,
      Value:            claimStatus,
    }
    assetJSON, err := json.Marshal(asset)
    if err != nil 
    {
      return err
    }

    return ctx.GetStub().PutState(moneyPool, assetJSON)
  }

// ReadAsset returns the asset stored in the world state with given id.
   func (s *SmartContract) ReadAsset(ctx contractapi.TransactionContextInterface, queryID int) (*Asset, error) 
   {
    assetJSON, err := ctx.GetStub().GetState(queryID)
    if err != nil {
      return nil, fmt.Errorf("failed to read from world state: %v", err)
    }
    if assetJSON == nil {
      return nil, fmt.Errorf("the asset %s does not exist", queryID)
    }

    var asset Asset
    err = json.Unmarshal(assetJSON, &asset)
    if err != nil {
      return nil, err
    }

    return &asset, nil
  }

// UpdateAsset updates an existing asset in the world state with provided parameters.
   func (s *SmartContract) UpdateAsset(ctx contractapi.TransactionContextInterface, queryID int,queryStatus string) error {
    exists, err := s.AssetExists(ctx, queryID)
    if err != nil 
    {
      return err
    }
    if !exists {
      return fmt.Errorf("the asset %s does not exist", queryID)
    }

    // overwriting original asset with new asset
    asset := Asset
    {
      CID:            claimID,
      PID:            personID,
      Details:            claimDetails,
      CID:            claimValue,
      Value:            queryStatus,
    }
    assetJSON, err := json.Marshal(asset)
    if err != nil 
    {
      return err
    }

    return ctx.GetStub().PutState(queryID, assetJSON)
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
   func (s *SmartContract) AssetExists(ctx contractapi.TransactionContextInterface, queryID string) (bool, error) 
   {
    assetJSON, err := ctx.GetStub().GetState(queryID)
    if err != nil 
    {
      return false, fmt.Errorf("failed to read from world state: %v", err)
    }

    return assetJSON != nil, nil
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