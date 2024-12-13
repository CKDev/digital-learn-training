import { Box, Button, Grid2, Link, Typography } from "@mui/material";
import React from "react";

// TODO: custom footer theme?

const Footer = ({ pages, contactEmail, logoFile, logoLinkDestination }) => (
  <Box sx={{ p: "20px", bgcolor: "info.dark" }}>
    <Typography sx={{ mb: "20px", textAlign: "center" }}>
      This work is licensed under a Creative Commons BY-NC-SA License
    </Typography>
    <Grid2 container spacing={4} display="flex" justifyContent="space-between">
      <Grid2 container display="flex" direction="column">
        <Typography variant="h67">Learn More</Typography>
        {pages.map((page) => (
          <Link key={`page-link-${page.label}`} href={page.path}>
            {page.label}
          </Link>
        ))}
      </Grid2>
      <Grid2
        container
        display="flex"
        direction="column"
        justifyContent="space-around"
      >
        <Button
          variant="outlined"
          href={`mailto:${contactEmail}`}
          sx={{
            color: "info.contrastText",
            borderColor: "info.contrastText",
          }}
        >
          Send us an Email
        </Button>
        <Link href={logoLinkDestination} target="_blank">
          <img src={logoFile} alt="Footer Logo" />
        </Link>
      </Grid2>
    </Grid2>
  </Box>
);

export default Footer;
