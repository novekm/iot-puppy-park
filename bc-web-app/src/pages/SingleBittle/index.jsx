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

// Common
import {
  ExternalLinkItem,
  InfoLink,
  Navigation,
  TableHeader,
} from '../../common/common-components-config';
import Sidebar from '../../common/components/Sidebar';

import { resourcesBreadcrumbs } from './breadcrumbs';

import {
  PageHeader,
  BittleDeviceDetailsTableConfig,
  BittleCommandsTableConfig,
  BittleCommandsTableConfig2,
} from './config';

// Styles
import '../../common/styles/base.scss';
// import toolsContent from '../SingleBittle/tools-content';

const BittleDeviceDetailsTable = ({
  loadHelpPanelContent,
  isInProgress,
  setToolsOpen,
}) => (
  <Container
    header={
      <Header
        variant="h2"
        // info={
        //   <InfoLink onFollow={() =>  setToolsOpen(true)} ariaLabel={'Information about distribution settings.'} />
        // }
      >
        Device Details
      </Header>
    }
  >
    <BittleDeviceDetailsTableConfig isInProgress={isInProgress} />
    <BittleCommandsTableConfig />
    {/* Option 2 for commands layout */}
    {/* <BittleCommandsTableConfig2 /> */}
  </Container>
);

const SingleBittle = () => {
  const [toolsOpen, setToolsOpen] = useState(false);

  // let {activityEventId} = useParams();
  return (
    <AppLayout
      navigation={<Sidebar activeHref="/single-bittle" />}
      // notifications={<Notifications successNotification={false} />}
      breadcrumbs={<Breadcrumbs />} // define these values in /breadcrumbs/index.js
      content={
        <ContentLayout
          header={
            <PageHeader
              buttons={[{ text: 'Edit' }, { text: 'Delete' }]}
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

export default SingleBittle;

export const Breadcrumbs = () => (
  <BreadcrumbGroup
    items={resourcesBreadcrumbs}
    expandAriaLabel="Show path"
    ariaLabel="Breadcrumbs"
  />
);

// export const FullPageHeader = ({

//   resourceName = 'carbon-lake-AGKI571',
//   createButtonText = 'Upload Emission Data',
//   // createButtonText = 'Upload File',
//   ...props
// }) => {
//   const navigate = useNavigate();
//   const isOnlyOneSelected = props.selectedItems.length === 1;

//   return (
//     <TableHeader
//       variant="awsui-h1-sticky"
//       title={resourceName}
//       actionButtons={
//         <SpaceBetween size="xs" direction="horizontal">
//           {/* <Button disabled={!isOnlyOneSelected}>View details</Button> */}
//           <Button disabled={!isOnlyOneSelected}>Edit</Button>
//           <Button disabled={props.selectedItems.length === 0}>Delete</Button>
//           {/* <Button onClick={() => navigate("/data-uploader")} variant="primary">{createButtonText}</Button> */}
//           {/* <Button onClick={() => navigate("/data-uploader")} variant="primary">{createButtonText}</Button> */}
//         </SpaceBetween>
//       }
//       {...props}
//     />
//   );
// };

// Info pop out window seen when clicking 'info' or the i in a circle button on right side of page
export const ToolsContent = () => (
  <HelpPanel
    header={<h2>Device Details</h2>}
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
      This page is a view into your selected Bittle and related information such
      as the Device Name, Device Id, Device Status, Battery, and more.
    </p>
  </HelpPanel>
);
