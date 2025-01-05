import React from "react";

import { Card, Grid2 as Grid, IconButton, Typography } from "@mui/material";
import InsertDriveFileRoundedIcon from "@mui/icons-material/InsertDriveFileRounded";
import DeleteRoundedIcon from "@mui/icons-material/DeleteRounded";
import ThemedIcon from "../../ThemedIcon";

const FileAttachment = ({ file, onDelete }) => {
  const handleDelete = () => {
    onDelete(file);
  };

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
            <Typography variant="subtitle1">{file.fileName}</Typography>
          </Grid>
          <Grid>
            <Typography variant="body2">{file.fileType}</Typography>
          </Grid>
        </Grid>
        <Grid>
          <IconButton
            color="primary"
            aria-label="Delete"
            onClick={handleDelete}
          >
            <DeleteRoundedIcon />
          </IconButton>
        </Grid>
      </Grid>
    </Card>
  );
};

export default FileAttachment;
