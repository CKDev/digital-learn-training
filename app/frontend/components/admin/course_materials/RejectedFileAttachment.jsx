import React from "react";

import { Card, Grid2 as Grid, Typography } from "@mui/material";
import InsertDriveFileRoundedIcon from "@mui/icons-material/InsertDriveFileRounded";
import ThemedIcon from "../../ThemedIcon";

const RejectedFileAttachment = ({ file }) => {
  return (
    <Card sx={{ p: 2 }}>
      <Grid
        container
        direction="row"
        justifyContent="space-between"
        alignItems="center"
      >
        <Grid sx={{ px: 1 }}>
          <ThemedIcon iconClass={InsertDriveFileRoundedIcon} />
        </Grid>
        <Grid container size="grow" direction="column" sx={{ px: 2 }}>
          <Grid>
            <Typography variant="subtitle1" color="error">
              {file.path} - {file.size} bytes
            </Typography>
          </Grid>
          <Grid>
            <Typography variant="body2" color="error">
              {file.errors.map((e) => e.message).join()}
            </Typography>
          </Grid>
        </Grid>
      </Grid>
    </Card>
  );
};

export default RejectedFileAttachment;
