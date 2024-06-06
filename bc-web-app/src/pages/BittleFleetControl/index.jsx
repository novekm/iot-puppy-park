/* eslint-disable no-console */
/* eslint-disable react-hooks/exhaustive-deps */
/* eslint-disable react/prop-types */
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
import { Link, useNavigate, useParams } from 'react-router-dom';
// COMPONENT IMPORTS
import {
  BreadcrumbGroup,
  Button,
  AppLayout,
  Container,
  Header,
  HelpPanel,
  Icon,
  SpaceBetween,
  ContentLayout,
} from '@cloudscape-design/components';

// Amplify
import { generateClient } from 'aws-amplify/api';
import { pubsub } from '../../config/amplify-config';

// Common
import {
  ExternalLinkItem,
  InfoLink,
  Navigation,
  TableHeader,
} from '../../common/common-components-config';
import Sidebar from '../../common/components/Sidebar';

// Page configuration components
import {
  PageHeader,
  BittleDeviceDetailsTableConfig,
  BittleCommandsTableConfig,
  BittleCommandsTableConfig2,
} from './config';

// API functions
import { getOneBittle } from '../../graphql/queries';

// Styles
import '../../common/styles/base.scss';

// Main component for page
const BittleFleetControl = () => {
  const [toolsOpen, setToolsOpen] = useState(false);
  const { DeviceId } = useParams();
  const [singleBittle, setSingleBittle] = useState([]);

  // Fetch data for one bittle by 'DeviceId' specified in browser URL via useParams hook
  const client = generateClient();
  const fetchSingleBittle = async () => {
    try {
      const singleBittleData = await client.graphql({
        query: getOneBittle,
        variables: { DeviceId: `${DeviceId}` },
      });
      const singleBittleDataList = singleBittleData.data.getOneBittle;
      console.log('Single Bittle List', singleBittleDataList);
      setSingleBittle(singleBittleDataList);
      // setLoading(false)
    } catch (error) {
      console.log('error on fetching single bittle', error);
    }
  };

  // Run the fetchSingleBittle() function on page load
  useEffect(() => {
    fetchSingleBittle();
  }, []);

  // Subscribe to the specific topic relating to the current bittle on the page on page load
  useEffect(() => {
    console.log("Global")
   const sub= pubsub.subscribe({ topics: 'bittles-global/sub' }).subscribe({
      next: (data) => console.log('Message received', data),
      error: (error) => console.error(error),
      complete: () => console.log('Done')
    });
    return () => {
      sub.unsubscribe();
    };
  }, []);

  return (
    <AppLayout
      navigation={<Sidebar activeHref="/bittle-fleet-control" />}
      // notifications={<Notifications successNotification={false} />}
      breadcrumbs={<Breadcrumbs />} // define these values in /breadcrumbs/index.js
      content={
        <ContentLayout
          header={
            <PageHeader
              buttons={[{ text: 'My Bittles', href: '/my-bittles' }]}
              // buttons={[{ text: 'Edit' }, { text: 'Delete' }]}
              // loadHelpPanelContent={this.loadHelpPanelContent.bind(this)}
            />
          }
        >
          <SpaceBetween size="l">
            <BittleDeviceDetailsTable isInProgress />
          </SpaceBetween>
        </ContentLayout>
      }
      contentType="table"
      tools={<ToolsContent />}
      toolsOpen={toolsOpen}
      onToolsChange={({ detail }) => setToolsOpen(detail.open)}
      stickyNotifications
    />
  );
};

export default BittleFleetControl;

// Bittle Device Details Table - Configuration is in config.jsx
const BittleDeviceDetailsTable = ({
  singleBittle,
  loadHelpPanelContent,
  isInProgress,
  setToolsOpen,
}) => {
  return (
    <Container
      header={
        <Header variant="h2">
          {/* Table Title */}
          Global Commands
        </Header>
      }
    >
      {/* <BittleDeviceDetailsTableConfig
        // Pass singleBittle data as prop

        isInProgress={isInProgress}
      /> */}
      <BittleCommandsTableConfig />
      {/* Option 2 for commands layout */}
      {/* <BittleCommandsTableConfig2 /> */}
    </Container>
  );
};

export const Breadcrumbs = ({ singleBittle }) => (
  <BreadcrumbGroup
    items={[
      {
        text: ' Bittle Control',
        href: '/dashboard',
      },
      {
        text: 'My Bittles',
        href: '/my-bittles',
      },
      {
        text: 'Fleet Control',
        href: '#',
      },
    ]}
    expandAriaLabel="Show path"
    ariaLabel="Breadcrumbs"
  />
);

// Info pop out window seen when clicking 'info' or the i in a circle button on right side of page
export const ToolsContent = () => (
  <HelpPanel
    header={<h2>Fleet Control</h2>}
    footer={
      <>
        <h3>
          Learn more{' '}
          <span role="img" aria-label="Icon external Link">
            <Icon name="external" />
          </span>
        </h3>
        <ul>
          <li>
            <ExternalLinkItem
              href="https://ghgprotocol.org/Third-Party-Databases/IPCC-Emissions-Factor-Database"
              text="IPCC Emissions Factor Database"
            />
          </li>
          <li>
            <ExternalLinkItem
              href="https://aws.amazon.com/energy/"
              text="AWS Energy & Utilities"
            />
          </li>
          <li>
            <ExternalLinkItem
              href="https://ghgprotocol.org/"
              text="GHG Protocol Guidance"
            />
          </li>
        </ul>
      </>
    }
  >
    <p>
      This page is for managing your entire fleet at scale. Click the buttons to
      issue global commands to all connected bittles.
    </p>
  </HelpPanel>
);
