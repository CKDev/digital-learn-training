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
        <Typography variant="body1" sx={{ mb: 1, color: "common.white" }}>
          <Link
            href="https://opensource.org/license/mit"
            target="_blank"
            rel="noopener noreferrer"
            color="inherit"
            underline="always"
          >
            Platform License: MIT
          </Link>
          {' | '}
          <Link
            href="https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode"
            target="_blank"
            rel="noopener noreferrer"
            color="inherit"
            underline="always"
          >
            Content License: CC BY-NC-SA 4.0
          </Link>
        </Typography>
        <Typography variant="body2" sx={{ mb: "20px", color: "common.white" }}>
          <Link href="/terms_of_use" color="inherit" underline="always">
            Terms of Use
          </Link>
          {' | '}
          <Link href="/privacy_policy" color="inherit" underline="always">
            Privacy Policy
          </Link>
        </Typography>
        <Link href={logoLinkDestination} target="_blank">
          <img src={logoFile} alt="Footer Logo" style={{ height: "3.5rem", width: "auto" }} />
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
