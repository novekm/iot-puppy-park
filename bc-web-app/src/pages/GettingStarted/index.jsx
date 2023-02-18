/* eslint-disable react/no-unescaped-entities */
/** **********************************************************************
                            DISCLAIMER

This is just a playground package. It does not comply with best practices
of using Cloudscape Design components. For production code, follow the
integration guidelines:

https://cloudscape.design/patterns/patterns/overview/
*********************************************************************** */

import React from 'react';

import {
  AppLayout,
  Container,
  Header,
  HelpPanel,
  Grid,
  Box,
  TextContent,
  SpaceBetween,
  Icon,
} from '@cloudscape-design/components';
import Sidebar from '../../common/components/Sidebar';

import { ExternalLinkItem } from '../../common/common-components-config';

import '../../common/styles/intro.scss';
import '../../common/styles/servicehomepage.scss';

// Import images
import awsLogo from '../../public/images/AWS_logo_RGB_REV.png';
import iacBasicArch from '../../../../resources/architecture/IAC_SAMPLE_ARCH.png';
import iacAdvancedArch from '../../../../resources/architecture/IAC_ADVANCED_ARCH.png';

const GettingStarted = () => {
  return (
    <AppLayout
      navigation={<Sidebar activeHref="#/" />}
      // navigation={<Sidebar activeHref="#/" items={navItems}/>}
      content={<Content />}
      tools={<ToolsContent />}
      headerSelector="#h"
      disableContentPaddings
      // toolsHide={true}
    />
  );
};

export default GettingStarted;

const Content = () => {
  return (
    <div>
      <TextContent>
        <div>
          <Grid className="custom-home__header" disableGutters>
            <Box margin="xxl" padding={{ vertical: 'xl', horizontal: 'l' }}>
              <Box margin={{ bottom: 's' }} />
              <img
                src={awsLogo}
                alt=""
                style={{ maxWidth: '20%', paddingRight: '2em' }}
              />
              <div className="custom-home__header-title">
                <Box fontSize="display-l" fontWeight="bold" color="inherit">
                  Bittle Control
                </Box>
                <Box
                  fontSize="display-l"
                  padding={{ bottom: 's' }}
                  fontWeight="light"
                  color="inherit"
                >
                  Control your fleet of Petoi Bittle robot dogs at scale.
                </Box>
                <Box fontWeight="light">
                  <span className="custom-home__header-sub-title">
                    This project serves as an example of how you can use AWS IoT
                    Core (and other services) to control and manage a fleet of
                    Petoi Bittles.
                    {/* Click <Link to={{ pathname: "/about-carbonlake"}}  target="_blank">here</Link> to learn more. */}
                    <br />
                    <br />
                    Click{' '}
                    <a
                      target="_blank"
                      rel="noopener noreferrer"
                      href="https://github.com/novekm/iot-puppy-park"
                    >
                      here
                    </a>{' '}
                    to learn more.
                  </span>
                </Box>
              </div>
            </Box>
          </Grid>
        </div>

        {/* Start 'This project is buit' section */}
        <Box margin="xxl" padding="l">
          <SpaceBetween size="l">
            <div>
              <h1>About Bittle Control</h1>
              <Container>
                <div>
                  <p>
                    This solution serves as an example of how you can use AWS
                    IoT Core (and other services) to control and manage a fleet
                    of Petoi Bittles through a web application. <br />
                    The solution was built by a team of AWS Solutions Architects
                    in the{' '}
                    <a
                      target="_blank"
                      rel="noopener noreferrer"
                      href="https://aws.amazon.com/energy/"
                    >
                      Energy & Utilities team.
                    </a>
                    <br />
                    <br />
                    This project provides the following:
                  </p>
                  <li>Bittle Control AWS Amplify Application</li>
                  <li>Bittle Control GraphQL API</li>
                  <li>IoT Connectivity</li>
                  <li>Realtime Video Streaming</li>
                  <li>Computer Vision</li>
                  <li>Amazon Alexa Integration</li>
                  <li>Authentication, Authorization, and Auditing</li>
                  <li>Secure Data Storage</li>
                  <p>
                    {/* Data is ingested through the Landing Bucket, and can be
                    ingested from any service within or connected to the AWS
                    cloud.
                    <br /> */}
                  </p>
                </div>
              </Container>
            </div>
            <div>
              <h1>Architecture</h1>
              <Container header={<Header>Basic Architecture</Header>}>
                {/* Make this flex later. maxWidth is not mobile responsive */}
                <div>
                  <img
                    src={iacBasicArch}
                    alt=""
                    style={{ maxWidth: '100%', paddingRight: '2em' }}
                  />
                </div>
                <div>{/* <p>This is the basic architecture.</p> */}</div>
              </Container>
              <Container header={<Header>Detailed Architecture</Header>}>
                <div>
                  <img
                    src={iacAdvancedArch}
                    alt=""
                    style={{ maxWidth: '100%', paddingRight: '2em' }}
                  />
                </div>
                <div>{/* <p>This is the detailed architecture.</p> */}</div>
              </Container>
            </div>
          </SpaceBetween>
        </Box>
      </TextContent>
    </div>
  );
};

export const ToolsContent = () => (
  <HelpPanel
    header={<h2>About</h2>}
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
      /* <li>
            <ExternalLinkItem
              href="https://aws.amazon.com/energy/"
              text="TBD - Amazon TCAQS Blog Post"
            />
          </li> */
    }
  >
    <p>
      This app is meant to serve as an example of an application you can build
      to control and manage{' '}
      <a
        target="_blank"
        rel="noopener noreferrer"
        href="https://www.petoi.com/pages/bittle-open-source-bionic-robot-dog?utm_source=google-ads&utm_campaign=&utm_agid=&utm_term=&gclid=Cj0KCQiA6LyfBhC3ARIsAG4gkF_2UaBXbb3ZYK9ByyeKexTDR-T0mHoVt15Ns3JeG9rYfrb9B9hyX_0aAtaYEALw_wcB"
      >
        {' '}
        Petoi Bittles.
      </a>
      <span> </span>
      <span>
        The app is built leveraging AWS Amplify, Cloudscape, Terraform, and the
        AWS Amplify Libraries for JavaScript. For more information, see
      </span>
      <a
        target="_blank"
        rel="noopener noreferrer"
        href="https://docs.amplify.aws/lib/q/platform/js/"
      >
        {' '}
        AWS Amplify Libraries for JavaScript,
      </a>
      <span> and</span>
      <a
        target="_blank"
        rel="noopener noreferrer"
        href="https://cloudscape.design/"
      >
        {' '}
        Cloudscape
      </a>
    </p>
  </HelpPanel>
);
