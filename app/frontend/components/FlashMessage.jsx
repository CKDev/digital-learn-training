import React, { useEffect, useState } from "react";
import Alert from "@mui/material/Alert";

const FlashMessage = () => {
  const [message, setMessage] = useState("");
  const [visible, setVisible] = useState(true);

  useEffect(() => {
    // Check if there's a flash message in localStorage
    const storedMessage = localStorage.getItem("flash_message");

    if (storedMessage) {
      setMessage(storedMessage);
      // Remove flash message from localStorage after loading it
      localStorage.removeItem("flash_message");

      // Set a timeout to hide the alert after 5 seconds
      setTimeout(() => {
        setVisible(false);
      }, 5000);
    }
  }, []);

  return (
    visible &&
    message && (
      <Alert severity="success" onClose={() => setVisible(false)}>
        {message}
      </Alert>
    )
  );
};

export default FlashMessage;
