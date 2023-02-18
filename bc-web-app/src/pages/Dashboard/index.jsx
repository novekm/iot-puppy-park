/* eslint-disable no-console */
/* eslint-disable no-unused-vars */
/* eslint-disable no-use-before-define */
/* eslint-disable no-undef */
/* eslint-disable react/prop-types */
/* eslint-disable import/order */
/** **********************************************************************
                            DISCLAIMER

This is just a playground package. It does not comply with best practices
of using Cloudscape Design components. For production code, follow the
integration guidelines:

https://cloudscape.design/patterns/patterns/overview/
*********************************************************************** */

import React, { useState, useEffect } from 'react';

// import { Link, useNavigate, useParams } from 'react-router-dom';
// COMPONENT IMPORTS
import {
  // Alert,
  // Badge,
  BreadcrumbGroup,
  // Button,
  // Flashbar,
  AppLayout,
  // SideNavigation,
  // Container,
  // Header,
  HelpPanel,
  Grid,
  Box,
  Icon,
  TextContent,
  // ContentLayout,
  // SpaceBetween,
} from '@cloudscape-design/components';
// import TopNavigationHeader from '../../common/components/TopNavigationHeader';
// Common
// import { useColumnWidths } from '../../common/resources/useColumnWidths';
import {
  // Notifications,
  ExternalLinkItem,
  // TableHeader,
} from '../../common/common-components-config';
import Sidebar from '../../common/components/Sidebar';
import { resourcesBreadcrumbs } from './breadcrumbs';

// import '../../common/styles/dashboard.scss';
import '../../common/styles/intro.scss';
import '../../common/styles/servicehomepage.scss';

// NEW
// import { DashboardHeader, EC2Info } from './Header';
import { FleetOverview } from './FleetOverview';
import { ServiceHealth } from './ServiceHealth';
import { EmissionsBarChart } from './S3ObjectsBarChart';
import { EmissionsLineChart } from './S3ObjectsLineChart';
import { withAuthenticator } from '@aws-amplify/ui-react';

import awsLogo from '../../public/images/AWS_logo_RGB_REV.png';

import { API, graphqlOperation } from 'aws-amplify';
import { getAllBittles } from '../../graphql/queries';

const Dashboard = ({ user }) => {
  return (
    <AppLayout
      breadcrumbs={<Breadcrumbs />}
      navigation={<Sidebar activeHref="/dashboard" />}
      content={
        // <ContentLayout header={<DashboardHeader />}>
        //   <Content />
        // </ContentLayout>
        <Content user={user} />
      }
      tools={<ToolsContent />}
      headerSelector="#h"
      disableContentPaddings
    />
  );
};

export default withAuthenticator(Dashboard);

const Content = ({ user }) => {
  const [bittles, setBittles] = useState([]);

  useEffect(() => {
    fetchBittles();
  }, []);

  // // 1. Map through existing 's3ObjectDataList' array and create new array with date properties for filtering
  // const dateSeparatedS3Objects = s3Objects.map((s3Object) => ({
  //   ObjectId: s3Object.ObjectId,
  //   Version: s3Object.Version,
  //   DetailType: s3Object.DetailType,
  //   Source: s3Object.Source,
  //   FilePath: s3Object.FilePath,
  //   AccountId: s3Object.AccountId,
  //   CreatedAt: s3Object.CreatedAt,
  //   Region: s3Object.Region,
  //   CurrentBucket: s3Object.CurrentBucket,
  //   OriginalBucket: s3Object.OriginalBucket,
  //   ObjectSize: s3Object.ObjectSize,
  //   SourceIPAddress: s3Object.SourceIPAddress,
  //   LifecycleConfig: s3Object.LifecycleConfig,

  //   // emissions_output: JSON.parse(emission.emissions_output),
  //   year: new Date(s3Object.CreatedAt).getFullYear(),
  //   month: new Date(s3Object.CreatedAt).getMonth() + 1,
  //   day: new Date(s3Object.CreatedAt).getDate(),
  //   // time: new Date(s3Object.CreatedAt).getTime(),
  // }));
  // console.log('Date Separated S3 Objects', dateSeparatedS3Objects);

  const fetchBittles = async () => {
    try {
      const BittleData = await API.graphql(
        graphqlOperation(getAllBittles, { limit: 10000 })
      );
      const BittleDataList = BittleData.data.getAllBittles.items;
      console.log('Bittle List', BittleDataList);
      setBittles(BittleDataList);
    } catch (error) {
      console.log('error on fetching bittles', error);
    }
  };
  // eslint-disable-next-line react/jsx-no-useless-fragment
  return (
    <>
      <TextContent>
        <div>
          <Grid className="custom-home__header" disableGutters>
            <Box margin="xxl" padding={{ vertical: '', horizontal: 'l' }}>
              <Box margin={{ bottom: 's' }} />
              <img
                src={awsLogo}
                alt=""
                style={{ maxWidth: '10%', paddingRight: '2em' }}
                // style={{ maxWidth: '20%', paddingRight: '2em' }}
              />
              <div className="custom-home__header-title">
                <Box fontSize="display-l" fontWeight="bold" color="inherit">
                  Hi, {user.attributes.given_name} 👋
                </Box>
                <Box
                  fontSize="heading-l"
                  padding={{ bottom: 's' }}
                  fontWeight="light"
                  color="inherit"
                >
                  Ready to get the day started?
                </Box>
              </div>
            </Box>
          </Grid>
        </div>
      </TextContent>
      <FleetOverview bittles={bittles} />
      {/* <EmissionsBarChart s3ObjectsMonthlyTotal={filteredS3ObjectsTotal2022} /> */}
      <EmissionsLineChart />
    </>
  );
};

export const Breadcrumbs = () => (
  <BreadcrumbGroup
    items={resourcesBreadcrumbs}
    expandAriaLabel="Show path"
    ariaLabel="Breadcrumbs"
  />
);

export const ToolsContent = () => (
  <HelpPanel
    header={<h2>Dashboard</h2>}
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
              href="https://aws.amazon.com/energy/"
              text="AWS Energy & Utilities"
            />
          </li>
          <li>
            <ExternalLinkItem
              href="https://github.com/novekm/iot-puppy-park"
              text="IoT Puppy Park GitHub Repo"
            />
          </li>
          <li>
            <ExternalLinkItem
              href="https://www.petoi.com/pages/bittle-open-source-bionic-robot-dog"
              text="Petoi Bittle"
            />
          </li>
          <li>
            <ExternalLinkItem
              href="https://www.petoi.camp/forum/"
              text="Petoi Forum"
            />
          </li>
        </ul>
      </>
    }
  >
    <p>
      The dashboard page serves as your single pane of glass into your relevant
      data points.
    </p>
  </HelpPanel>
);
