import { Button } from "@mui/material";
import ArrowBackRoundedIcon from "@mui/icons-material/ArrowBackRounded";
import React from "react";

const ReturnToCategoryLink = ({ category, categoryFriendlyId, language }) => (
  <Button
    variant="text"
    startIcon={<ArrowBackRoundedIcon />}
    href={`/courses?category=${categoryFriendlyId}&language=${language}`}
  >
    Back to {category}
  </Button>
);

export default ReturnToCategoryLink;
