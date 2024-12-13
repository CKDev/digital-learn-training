import { Button } from "@mui/material";
import ArrowBackRoundedIcon from "@mui/icons-material/ArrowBackRounded";
import React from "react";

const ReturnToCategoryLink = ({ category, categoryId }) => (
  <Button
    variant="text"
    startIcon={<ArrowBackRoundedIcon />}
    href={`/courses?selected_category=${categoryId}`}
  >
    Back to {category}
  </Button>
);

export default ReturnToCategoryLink;
