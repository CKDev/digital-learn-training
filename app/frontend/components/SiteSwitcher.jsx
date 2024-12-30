import { Box, Button, Container, Grid2, Typography } from "@mui/material";
import ForwardRoundedIcon from "@mui/icons-material/ForwardRounded";
import React from "react";

const SiteSwitcher = ({ switcherUrl }) => (
  <Box pt={2} pb={2}>
    <Grid2 container display="flex" justifyContent="space-between">
      <Grid2 display="flex" alignItems="baseline" container size={8} gap={1}>
        <Typography variant="overline" display="inline">
          Current Site:{" "}
        </Typography>
        <Typography display="inline">Trainers</Typography>
      </Grid2>
      <Button
        size="small"
        variant="text"
        disableElevation
        endIcon={<ForwardRoundedIcon />}
        href={switcherUrl}
      >
        Switch to Learners Site
      </Button>
    </Grid2>
  </Box>
);

export default SiteSwitcher;
