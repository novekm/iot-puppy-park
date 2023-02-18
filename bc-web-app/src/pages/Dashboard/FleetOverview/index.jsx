/* eslint-disable react/prop-types */
/* eslint-disable react/jsx-no-useless-fragment */
import React from 'react';
import {
  Box,
  Container,
  Header,
  ColumnLayout,
} from '@cloudscape-design/components';
import { CounterLink } from '../common-components';

export const FleetOverview = ({ bittles }) => {
  return (
    <>
      <Box margin="xxl" padding={{ vertical: '', horizontal: 'l' }}>
        <Container
          className="custom-dashboard-container"
          header={
            <Header
              variant="h2"
              description="Viewing realtime data for your Bittle fleet."
            >
              Fleet Overview
            </Header>
          }
        >
          <ColumnLayout columns="4" variant="text-grid">
            <div>
              <Box variant="awsui-key-label">Devices</Box>
              {/* <CounterLink>4</CounterLink> */}
              <CounterLink>{bittles.length}</CounterLink>
            </div>
            <div>
              <Box variant="awsui-key-label">Locations</Box>
              <CounterLink>1</CounterLink>
            </div>
            <div>
              <Box variant="awsui-key-label">Warnings</Box>
              <CounterLink>0</CounterLink>
            </div>
            <div>
              <Box variant="awsui-key-label">Errors</Box>
              <CounterLink>0</CounterLink>
            </div>
          </ColumnLayout>
        </Container>
      </Box>
    </>
  );
};
