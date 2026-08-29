import React, { useState } from "react";
import { sendRequest } from "@api/Api";

import {
  TextField,
  Button,
  Box,
  Typography,
  Alert,
  Grid2 as Grid,
} from "@mui/material";

const InvitationNew = ({ invitationPath, prefillEmail }) => {
  const [email, setEmail] = useState(prefillEmail || "");
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    const payload = JSON.stringify({ user: { email: email } });
    const response = await sendRequest(invitationPath, "POST", payload);

    if (response.success) {
      localStorage.setItem("flash_message", response.data.message);
      window.location = response.data.redirectPath;
    } else {
      setError(response.message);
    }
  };

  return (
    <Box
      component="form"
      onSubmit={handleSubmit}
      sx={{ maxWidth: 600, my: 0, mx: "auto", p: 4, borderRadius: 2 }}
    >
      <Grid container direction="column" gap={2} alignItems="center">
        <Typography variant="h6" textAlign="center">
          Invite Collaborator to DigitalLearn
        </Typography>

        <Typography variant="body2" textAlign="center" color="text.secondary">
          This feature currently applies to the AT&T training subdomain only.
        </Typography>

        {error && <Alert severity="error">{error}</Alert>}

        <TextField
          label="Email"
          type="email"
          variant="outlined"
          fullWidth
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <Button type="submit" variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          Send Invitation
        </Button>
      </Grid>
    </Box>
  );
};

export default InvitationNew;
