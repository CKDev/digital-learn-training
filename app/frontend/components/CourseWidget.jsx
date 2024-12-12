import React from "react";
import {
  Card,
  Button,
  Paper,
  CardHeader,
  CardContent,
  CardActions,
  Typography,
} from "@mui/material";

const CourseWidget = ({
  title,
  description,
  courseMaterialUrl,
  materialsDownloadUrl,
  fileCount,
  imageCount,
  videoCount,
}) => (
  <Card sx={{ width: 570 }}>
    <Paper>
      <CardHeader
        title={title}
        subheader={
          <CourseWidgetSubheader
            fileCount={fileCount}
            imageCount={imageCount}
            videoCount={videoCount}
          />
        }
      />
      <CardContent dangerouslySetInnerHTML={{ __html: description }} />
      <CardActions>
        <Button variant="contained" color="primary" href={courseMaterialUrl}>
          View Course Materials
        </Button>
        {fileCount + imageCount + videoCount > 0 && (
          <Button
            variant="outlined"
            onClick={() => window.open(materialsDownloadUrl, "_blank")}
          >
            Download All Materials
          </Button>
        )}
      </CardActions>
    </Paper>
  </Card>
);

const CourseWidgetSubheader = ({ fileCount, imageCount, videoCount }) => {
  let downloadableCounts = [
    { count: fileCount, label: fileCount == 1 ? "File" : "Files" },
    { count: imageCount, label: imageCount == 1 ? "Image" : "Images" },
    { count: videoCount, label: videoCount == 1 ? "Video" : "Videos" },
  ]
    .filter((downloadable) => downloadable.count > 0)
    .map((downloadable) => downloadable.count + " " + downloadable.label)
    .join(" | ");

  return <Typography variant="body2">{downloadableCounts}</Typography>;
};

export default CourseWidget;
