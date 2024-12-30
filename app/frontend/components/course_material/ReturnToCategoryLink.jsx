import { Button } from "@mui/material";
import ArrowBackRoundedIcon from "@mui/icons-material/ArrowBackRounded";
import React from "react";

const ReturnToCategoryLink = ({ category, categoryId, language }) => (
  <Button
    variant="text"
    startIcon={<ArrowBackRoundedIcon />}
    href={`/courses?selected_category=${categoryId}&selected_language=${language}`}
  >
    Back to {category}
  </Button>
);

export default ReturnToCategoryLink;
