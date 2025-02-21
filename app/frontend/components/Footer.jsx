import React from "react";

import { Box, Button, Grid2, Link, Typography } from "@mui/material";
import AccountBoxRoundedIcon from "@mui/icons-material/AccountBoxRounded";

const Footer = ({
  pages,
  contactEmail,
  logoFile,
  logoLinkDestination,
  adminSignedIn,
}) => {
  return (
    <Box>
      <Box sx={{ p: "20px", bgcolor: "info.dark", textAlign: "center" }}>
        <Typography sx={{ mb: "20px", color: "common.white" }}>
          This work is licensed under a Creative Commons BY-NC-SA License
        </Typography>
        <Link href={logoLinkDestination} target="_blank">
          <img src={logoFile} alt="Footer Logo" />
        </Link>
      </Box>
      <Box sx={{ p: "20px" }}>
        <Grid2 container spacing={4} display="flex">
          <Grid2 size={6} container display="flex" direction="column" gap={1}>
            <Typography variant="h6">Learn More</Typography>
            {pages.map((page) => (
              <Link key={`page-link-${page.label}`} href={page.path}>
                {page.label}
              </Link>
            ))}
          </Grid2>
          <Grid2 container display="flex" direction="column" gap={1}>
            <Button variant="outlined" href={`mailto:${contactEmail}`}>
              Send us an Email
            </Button>
            {adminSignedIn ? (
              <Button variant="text" disableElevation href="/admin">
                Admin Dashboard
              </Button>
            ) : (
              <Button
                variant="text"
                disableElevation
                endIcon={<AccountBoxRoundedIcon />}
                href="/users/sign_in"
              >
                Admin Sign In
              </Button>
            )}
          </Grid2>
        </Grid2>
      </Box>
    </Box>
  );
};

export default Footer;
