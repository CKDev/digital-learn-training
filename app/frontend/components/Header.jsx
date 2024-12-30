import React from "react";

import { Container, Button, Grid2 as Grid, Link } from "@mui/material";
import SiteSwitcher from "./SiteSwitcher";
import AccountBoxRoundedIcon from "@mui/icons-material/AccountBoxRounded";
import FlashMessage from "./FlashMessage";

const Header = ({ logoLinkUrl, logoFile, switcherUrl, isAuthenticated }) => {
  const handleSignOut = async (event) => {
    event.preventDefault();

    try {
      const response = await fetch("/users/sign_out", {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        },
      });

      if (response.ok) {
        const data = await response.json();
        localStorage.setItem("flash_message", data.message);
        window.location = "/";
      } else {
        console.error("Failed to Sign Out:", response.statusText);
      }
    } catch (error) {
      console.error("Error sending Sign Out request:", error);
    }
  };

  return (
    <Container maxWidth="lg">
      <SiteSwitcher switcherUrl={switcherUrl} />
      <Grid container justifyContent="space-between">
        <Link href={logoLinkUrl}>
          <img src={logoFile} alt="Header Logo" />
        </Link>
        {isAuthenticated && (
          <Button
            variant="text"
            disableElevation
            endIcon={<AccountBoxRoundedIcon />}
            onClick={handleSignOut}
          >
            Sign Out
          </Button>
        )}
      </Grid>
      <FlashMessage />
    </Container>
  );
};

export default Header;
