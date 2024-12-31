import { Box, Drawer, Grid2 as Grid, IconButton } from "@mui/material";
import React, { useState } from "react";
import MenuIcon from "@mui/icons-material/Menu";
import ChevronLeftRoundedIcon from "@mui/icons-material/ChevronLeftRounded";
import SidebarTabs from "./SidebarTabs";

const SidebarDrawer = ({ ...tabsProps }) => {
  const [open, setOpen] = useState(false);
  const toggleDrawer = (newOpen) => () => {
    setOpen(newOpen);
  };

  return (
    <Box>
      <IconButton
        color="inherit"
        aria-label="open drawer"
        edge="start"
        onClick={toggleDrawer(true)}
        sx={{ display: { md: "none" } }}
      >
        <MenuIcon />
      </IconButton>
      <Drawer
        open={open}
        onClose={toggleDrawer(false)}
        ModalProps={{
          keepMounted: true, // Improve performance for mobile
        }}
      >
        <Grid container justifyContent={"flex-end"} sx={{ p: 1 }}>
          <IconButton size="large" onClick={toggleDrawer(false)}>
            <ChevronLeftRoundedIcon />
          </IconButton>
        </Grid>
        <SidebarTabs {...tabsProps} />
      </Drawer>
    </Box>
  );
};

export default SidebarDrawer;
