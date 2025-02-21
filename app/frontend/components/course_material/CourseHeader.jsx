import {
  Button,
  Card,
  CardHeader,
  CardContent,
  CardActions,
  Paper,
  Typography,
} from "@mui/material";
import React from "react";
import ContributorAttribution from "../ContributorAttribution";

const CourseHeader = ({
  title,
  summary,
  description,
  providedByAtt,
  fileCount,
  imageCount,
  videoCount,
  materialsDownloadUrl,
}) => (
  <Card elevation={0}>
    <Paper elevation={0} sx={{ bgcolor: "primary.light" }}>
      <CardHeader
        title={title}
        action={providedByAtt == true && <ContributorAttribution />}
        subheader={
          <CourseWidgetSubheader
            fileCount={fileCount}
            imageCount={imageCount}
            videoCount={videoCount}
          />
        }
      />
      <CardContent>
        <Typography>{summary}</Typography>
        {description != undefined && (
          <div dangerouslySetInnerHTML={{ __html: description }} />
        )}
      </CardContent>
      <CardActions>
        {fileCount + imageCount + videoCount > 0 && (
          <Button
            sx={{ bgcolor: "white" }}
            variant="outlined"
            href={materialsDownloadUrl}
            target="_blank"
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

export default CourseHeader;
