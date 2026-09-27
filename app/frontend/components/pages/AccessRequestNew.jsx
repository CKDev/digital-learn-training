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
import Recaptcha from "../Recaptcha";

const AccessRequestNew = ({ accessRequestsPath, recaptchaSiteKey }) => {
  const [fullName, setFullName] = useState("");
  const [organizationName, setOrganizationName] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [requestReason, setRequestReason] = useState("");
  const [pocName, setPocName] = useState("");
  const [pocEmail, setPocEmail] = useState("");
  const [recaptchaToken, setRecaptchaToken] = useState("");
  const [recaptchaKey, setRecaptchaKey] = useState(0);
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    const payload = JSON.stringify({
      access_request: {
        full_name: fullName,
        organization_name: organizationName,
        email: email,
        phone: phone,
        request_reason: requestReason,
        poc_name: pocName,
        poc_email: pocEmail,
      },
      "g-recaptcha-response": recaptchaToken,
    });

    const response = await sendRequest(accessRequestsPath, "POST", payload);

    if (response.success) {
      localStorage.setItem("flash_message", response.data.message);
      window.location = response.data.redirectPath;
    } else {
      setError(response.message);
      setRecaptchaToken("");
      setRecaptchaKey((key) => key + 1);
    }
  };

  return (
    <Box
      component="form"
      onSubmit={handleSubmit}
      sx={{ maxWidth: 600, my: 0, mx: "auto", p: 4, borderRadius: 2 }}
    >
      <Grid container direction="column" gap={2}>
        <Typography variant="h6" textAlign="center">
          Request Collaborator Access
        </Typography>

        {error && <Alert severity="error">{error}</Alert>}

        <TextField
          label="Full Name"
          variant="outlined"
          fullWidth
          value={fullName}
          onChange={(e) => setFullName(e.target.value)}
          required
        />
        <TextField
          label="Organization Name"
          variant="outlined"
          fullWidth
          value={organizationName}
          onChange={(e) => setOrganizationName(e.target.value)}
          required
        />
        <TextField
          label="Email"
          type="email"
          variant="outlined"
          fullWidth
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <TextField
          label="Phone Number"
          variant="outlined"
          fullWidth
          value={phone}
          onChange={(e) => setPhone(e.target.value)}
          required
          slotProps={{ htmlInput: { maxLength: 10 } }}
        />
        <TextField
          label="Please provide a brief explanation for requesting access to materials"
          variant="outlined"
          fullWidth
          multiline
          rows={3}
          value={requestReason}
          onChange={(e) => setRequestReason(e.target.value)}
        />

        <Typography variant="subtitle1">AT&T Point of Contact info</Typography>

        <TextField
          label="Point of Contact First Name"
          variant="outlined"
          fullWidth
          value={pocName}
          onChange={(e) => setPocName(e.target.value)}
        />
        <TextField
          label="Point of Contact Email address"
          type="email"
          variant="outlined"
          fullWidth
          value={pocEmail}
          onChange={(e) => setPocEmail(e.target.value)}
        />

        <Recaptcha
          key={recaptchaKey}
          siteKey={recaptchaSiteKey}
          onChange={setRecaptchaToken}
        />

        <Button type="submit" variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          Submit Access Request
        </Button>
      </Grid>
    </Box>
  );
};

export default AccessRequestNew;
