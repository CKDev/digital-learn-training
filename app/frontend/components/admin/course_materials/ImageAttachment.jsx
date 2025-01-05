import React from "react";

import { Card, Grid2 as Grid, IconButton, Typography } from "@mui/material";
import DeleteRoundedIcon from "@mui/icons-material/DeleteRounded";

const ImageAttachment = ({ image, onDelete }) => {
  const handleDelete = () => {
    onDelete(image);
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
          <img
            src={`${image.thumbnailUrl}`}
            alt={image.fileName}
            style={{ maxWidth: "112px" }}
          />
        </Grid>
        <Grid container size="grow" direction="column" sx={{ px: 2 }}>
          <Grid>
            <Typography variant="subtitle1">{image.fileName}</Typography>
          </Grid>
          <Grid>
            <Typography variant="body2">{image.fileType}</Typography>
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

export default ImageAttachment;
