/* eslint-disable */
// this is an auto generated file. This will be overwritten
export const getAllObjects = /* GraphQL */ `
  query GetAllObjects($limit: Int, $nextToken: String) {
    getAllObjects(limit: $limit, nextToken: $nextToken) {
      items {
        ObjectId
        Version
        DetailType
        Source
        FilePath
        AccountId
        CreatedAt
        Region
        CurrentBucket
        OriginalBucket
        ObjectSize
        SourceIPAddress
        LifecycleConfig
      }
      nextToken
    }
  }
`;
export const getAllObjectsPaginated = /* GraphQL */ `
  query GetAllObjectsPaginated($limit: Int, $nextToken: String) {
    getAllObjectsPaginated(limit: $limit, nextToken: $nextToken) {
      items {
        ObjectId
        Version
        DetailType
        Source
        FilePath
        AccountId
        CreatedAt
        Region
        CurrentBucket
        OriginalBucket
        ObjectSize
        SourceIPAddress
        LifecycleConfig
      }
      nextToken
    }
  }
`;
export const getOneObject = /* GraphQL */ `
  query GetOneObject($DeviceId: String!) {
    getOneBittle(ObjectId: $ObjectId) {
      ObjectId
      Version
      DetailType
      Source
      FilePath
      AccountId
      CreatedAt
      Region
      CurrentBucket
      OriginalBucket
      ObjectSize
      SourceIPAddress
      LifecycleConfig
    }
  }
`;

// New
export const getAllBittles = /* GraphQL */ `
  query GetAllBittles($limit: Int, $nextToken: String) {
    getAllBittles(limit: $limit, nextToken: $nextToken) {
      items {
        DeviceId
        DeviceName
        DeviceStatus
        Battery
        ShortName
        NyboardVersion
      }
      nextToken
    }
  }
`;
export const getAllBittlesPaginated = /* GraphQL */ `
  query GetAllBittlesPaginated($limit: Int, $nextToken: String) {
    getAllBittlesPaginated(limit: $limit, nextToken: $nextToken) {
      items {
        DeviceId
        DeviceName
        DeviceStatus
        Battery
        ShortName
        NyboardVersion
      }
      nextToken
    }
  }
`;
export const getOneBittle = /* GraphQL */ `
  query GetOneBittle($DeviceId: String!) {
    getOneBittle(DeviceId: $DeviceId) {
      DeviceId
        DeviceName
        DeviceStatus
        Battery
        ShortName
        NyboardVersion
    }
  }
`;
