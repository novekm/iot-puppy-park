/* eslint-disable no-console */
/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable no-use-before-define */
/* eslint-disable react/no-array-index-key */
/* eslint-disable react/prop-types */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable no-unused-vars */
/* eslint-disable no-undef */
/** **********************************************************************
                            DISCLAIMER

This is just a playground package. It does not comply with best practices
of using Cloudscape Design components. For production code, follow the
integration guidelines:

https://cloudscape.design/patterns/patterns/overview/
*********************************************************************** */
import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router';
import {
  Box,
  BreadcrumbGroup,
  Button,
  ButtonDropdown,
  ColumnLayout,
  Container,
  Header,
  ProgressBar,
  StatusIndicator,
  SpaceBetween,
  Table,
} from '@cloudscape-design/components';
import { API, graphqlOperation } from 'aws-amplify';
import {
  TableEmptyState,
  InfoLink,
} from '../../common/common-components-config';

import { getOneBittle } from '../../graphql/queries';

export const PageHeader = ({ buttons }) => {
  const { DeviceId } = useParams();
  return (
    <Header
      variant="h1"
      actions={
        <SpaceBetween direction="horizontal" size="xs">
          {buttons.map((button, key) =>
            !button.items ? (
              <Button
                href={button.href || ''}
                disabled={button.disabled || false}
                key={key}
              >
                {button.text}
              </Button>
            ) : (
              <ButtonDropdown items={button.items} key={key}>
                {button.text}
              </ButtonDropdown>
            )
          )}
        </SpaceBetween>
      }
    >
      {/* {SINGLE_BITTLE.id} */}
      {/* hello */}
      {/* TODO - Pass in Bittle prop and reference the DeviceName below */}
      {DeviceId}
      {/* Bittle 2 */}
    </Header>
  );
};

// Content/formatting for the Bittle Device Details table
export const BittleDeviceDetailsTableConfig = ({ isInProgress }) => {
  const { DeviceId } = useParams();
  const [singleBittle, setSingleBittle] = useState([]);
  useEffect(() => {
    fetchSingleBittle();
  }, []);

  const fetchSingleBittle = async () => {
    // let { DeviceId } = useParams();
    try {
      const singleBittleData = await API.graphql(
        graphqlOperation(getOneBittle, { DeviceId: `${DeviceId}` })
      );
      const singleBittleDataList = singleBittleData.data.getOneBittle;
      console.log('Single Bittle List', singleBittleDataList);
      setSingleBittle(singleBittleDataList);
      // setLoading(false)
    } catch (error) {
      console.log('error on fetching single bittle', error);
    }
  };

  const bittleData = singleBittle;
  console.log(bittleData);

  return (
    <ColumnLayout columns={3} variant="text-grid">
      {/* ------------ FIRST COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        <div>
          <Box variant="awsui-key-label">Device Name</Box>
          <div>{singleBittle.DeviceName}</div>
        </div>

        {/* Second Item */}
        <div>
          <Box variant="awsui-key-label">Device Id</Box>
          <div>{singleBittle.DeviceId}</div>
        </div>
      </SpaceBetween>

      {/* ------------ SECOND COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        <div>
          {/* TODO - Parse data for emissions_output with JSON.parse() */}
          <Box variant="awsui-key-label">Short Name</Box>
          <div>{singleBittle.ShortName}</div>
        </div>

        {/* Second Item */}
        <div>
          <Box variant="awsui-key-label">Nyboard Version</Box>
          <div>{singleBittle.NyboardVersion}</div>
        </div>
      </SpaceBetween>

      {/* ------------ THIRD COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        {singleBittle.DeviceStatus ? (
          <StatusIndicator
            type={
              singleBittle.DeviceStatus === 'Disconnected' ? 'error' : 'success'
            }
          >
            {singleBittle.DeviceStatus}
          </StatusIndicator>
        ) : (
          <ProgressBar
            value={27}
            label="Battery"
            // description={isInProgress ? 'Update in progress' : undefined}
            variant="key-value"
            resultText="Available"
            status={isInProgress ? 'in-progress' : 'success'}
          />
        )}
        {/* Second Item */}
        <div>
          <Box variant="awsui-key-label">Device Status</Box>
          <div>Connected</div>
        </div>
      </SpaceBetween>
      {/* <div className="VideoStreamContainer">TODO - ADD KINESIS VIDEO HERE</div> */}
    </ColumnLayout>
  );
};
// OPTION 1 - Content/formatting for the Bittle Commands table
export const BittleCommandsTableConfig = () => {
  return (
    <ColumnLayout columns={3} variant="text-grid">
      {/* ------------ FIRST COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        <div>
          <Box variant="awsui-key-label">Movements</Box>
          <div>
            <Button>Forward</Button>
          </div>
          <div>
            <Button>Forward L</Button>
            <Button>Forward R</Button>
          </div>
          <div>
            <Button>Back L</Button>
            <Button>Back R</Button>
          </div>
          <div>
            <Button>Back</Button>
            <Button variant="primary">Stop</Button>
          </div>
        </div>
      </SpaceBetween>

      {/* ------------ SECOND COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        <div>
          {/* TODO - Parse data for emissions_output with JSON.parse() */}
          <Box variant="awsui-key-label">Mode</Box>
          <div>
            <Button>Gyro On/Off</Button>
          </div>
          <div>
            <Button>Calibration</Button>
          </div>
          <div>
            <Button>Balanced</Button>
          </div>
        </div>
      </SpaceBetween>

      {/* ------------ THIRD COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        <div>
          {/* TODO - Parse data for emissions_output with JSON.parse() */}
          <Box variant="awsui-key-label">Actions</Box>
          <div>
            <Button>Walk</Button>
            <Button>Sit</Button>
            <Button>Hello</Button>
          </div>
          <div>
            <Button>Pee</Button>
            <Button>Trot</Button>
            <Button>Check</Button>
          </div>
          <div>
            <Button>Stepping</Button>
            <Button>Push Ups</Button>
          </div>
          <div>
            <Button>Stretch</Button>
            <Button>Butt Up</Button>
            <Button>Run</Button>
            <Button>Crawl</Button>
          </div>
        </div>
      </SpaceBetween>

      {/* <div className="VideoStreamContainer">TODO - ADD KINESIS VIDEO HERE</div> */}
    </ColumnLayout>
  );
};
// OPTION 2 - Content/formatting for the Bittle Commands table
export const BittleCommandsTableConfig2 = () => {
  return (
    <ColumnLayout columns={3} variant="text-grid">
      {/* ------------ FIRST COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        <div>
          <Box variant="awsui-key-label">Actions</Box>
          <div>
            <Button>Walk</Button>
            <Button>Sit</Button>
          </div>
          <div>
            <Button>Hello</Button>
            <Button>Pee</Button>
          </div>
        </div>
      </SpaceBetween>

      {/* ------------ SECOND COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        <div>
          <Box variant="awsui-key-label"> More Actions</Box>
          <div>
            <Button>Trot</Button>
            <Button>Check</Button>
          </div>
          <div>
            <Button>Stretch</Button>
            <Button>Push Ups</Button>
          </div>
        </div>
      </SpaceBetween>

      {/* ------------ THIRD COLUMN ------------ */}
      <SpaceBetween size="l">
        {/* First Item */}
        <div>
          <Box variant="awsui-key-label">Even MORE Actions</Box>
          <div>
            <Button>Crawl</Button>
            <Button>Buttup</Button>
          </div>
          <div>
            <Button>Run</Button>
            <Button>Stepping</Button>
          </div>
        </div>
      </SpaceBetween>

      {/* <div className="VideoStreamContainer">TODO - ADD KINESIS VIDEO HERE</div> */}
    </ColumnLayout>
  );
};

// May not need this

// export const EmptyTable = props => {
//   const resourceType = props.title || 'Tag';
//   const colDefs = props.columnDefinitions || TAGS_COLUMN_DEFINITIONS;
//   return (
//     <Table
//       empty={<TableEmptyState resourceName={resourceType} />}
//       columnDefinitions={colDefs}
//       items={[]}
//       header={
//         <Header
//           actions={
//             <SpaceBetween size="xs" direction="horizontal">
//               <Button disabled={true}>Edit</Button>
//               <Button disabled={true}>Delete</Button>
//               <Button>Create {resourceType.toLowerCase()}</Button>
//             </SpaceBetween>
//           }
//         >{`${resourceType}s`}</Header>
//       }
//     />
//   );
// };
