import React from "react";
import {
  Box,
  Button,
  Grid2 as Grid,
  Tab,
  Tabs,
  Typography,
} from "@mui/material";

const SidebarTabs = ({
  a11yProps,
  handleNavigation,
  checklistDownloadPath,
  userHttpRoutes,
  currentPath,
}) => (
  <Box>
    <Tabs
      orientation="vertical"
      variant="scrollable"
      value={currentPath}
      onChange={handleNavigation}
      aria-label="User Navigation Menu"
      sx={{ borderRight: 1, borderColor: "divider" }}
    >
      {userHttpRoutes.map((route, index) => (
        <Tab
          label={route.title}
          value={route.path}
          {...a11yProps(route.path)}
          key={"user-nav-tab-" + route.path}
          sx={
            index == userHttpRoutes.length - 1
              ? {
                  borderBottom: 1,
                  borderColor: "divider",
                }
              : {}
          }
        />
      ))}
    </Tabs>
    <Box sx={{ p: 2 }}>
      <Grid container direction="column" spacing={1}>
        <Typography variant="h6">Tech Skills Checklist</Typography>
        <Typography variant="caption">
          A tool for Public Library Supervisors & Staff to Evaluate their Tech
          Skills
        </Typography>
        <Button
          size="small"
          variant="contained"
          color="primary"
          href={checklistDownloadPath}
          target="_blank"
          sx={{ px: "10px", py: "4px" }}
        >
          Download Checklist (PDF)
        </Button>
      </Grid>
    </Box>
  </Box>
);

export default SidebarTabs;
