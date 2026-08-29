import React, { useState } from "react";
import { sendRequest } from "@api/Api";

import {
  TextField,
  Button,
  Box,
  Typography,
  Alert,
  Checkbox,
  FormControlLabel,
  Grid2 as Grid,
} from "@mui/material";
import Recaptcha from "../Recaptcha";

const InvitationEdit = ({
  invitationPath,
  invitationToken,
  email,
  requirePassword,
  stateOptions,
  recaptchaSiteKey,
  initialProfile,
}) => {
  const [password, setPassword] = useState("");
  const [passwordConfirmation, setPasswordConfirmation] = useState("");
  const [firstName, setFirstName] = useState(initialProfile?.firstName || "");
  const [lastName, setLastName] = useState(initialProfile?.lastName || "");
  const [phone, setPhone] = useState(initialProfile?.phone || "");
  const [organizationName, setOrganizationName] = useState(initialProfile?.organizationName || "");
  const [organizationCity, setOrganizationCity] = useState(initialProfile?.organizationCity || "");
  const [organizationState, setOrganizationState] = useState(initialProfile?.organizationState || "");
  const [pocName, setPocName] = useState(initialProfile?.pocName || "");
  const [pocEmail, setPocEmail] = useState(initialProfile?.pocEmail || "");
  const [termsOfService, setTermsOfService] = useState(false);
  const [recaptchaToken, setRecaptchaToken] = useState("");
  const [recaptchaKey, setRecaptchaKey] = useState(0);
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();

    const payload = JSON.stringify({
      user: {
        invitation_token: invitationToken,
        password: password,
        password_confirmation: passwordConfirmation,
        collaborator_profile_attributes: {
          first_name: firstName,
          last_name: lastName,
          phone: phone,
          organization_name: organizationName,
          organization_city: organizationCity,
          organization_state: organizationState,
          poc_name: pocName,
          poc_email: pocEmail,
          terms_of_service: termsOfService,
        },
      },
      "g-recaptcha-response": recaptchaToken,
    });

    const response = await sendRequest(invitationPath, "PUT", payload);

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
          Create Collaborator Account
        </Typography>

        {error && <Alert severity="error">{error}</Alert>}

        {requirePassword && (
          <>
            <TextField
              label="Email Address"
              type="email"
              variant="outlined"
              fullWidth
              value={email}
              disabled
            />
            <TextField
              label="Password"
              type="password"
              variant="outlined"
              fullWidth
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
            <TextField
              label="Password confirmation"
              type="password"
              variant="outlined"
              fullWidth
              value={passwordConfirmation}
              onChange={(e) => setPasswordConfirmation(e.target.value)}
              required
            />
          </>
        )}

        <TextField
          label="First Name"
          variant="outlined"
          fullWidth
          value={firstName}
          onChange={(e) => setFirstName(e.target.value)}
          required
        />
        <TextField
          label="Last Name"
          variant="outlined"
          fullWidth
          value={lastName}
          onChange={(e) => setLastName(e.target.value)}
          required
        />
        <TextField
          label="Phone"
          variant="outlined"
          fullWidth
          value={phone}
          onChange={(e) => setPhone(e.target.value)}
          required
          slotProps={{ htmlInput: { maxLength: 10 } }}
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
          label="Organization City"
          variant="outlined"
          fullWidth
          value={organizationCity}
          onChange={(e) => setOrganizationCity(e.target.value)}
          required
        />
        <TextField
          label="Organization State"
          select
          slotProps={{ select: { native: true } }}
          variant="outlined"
          fullWidth
          value={organizationState}
          onChange={(e) => setOrganizationState(e.target.value)}
          required
        >
          <option value="" />
          {stateOptions.map((option) => (
            <option key={option.value} value={option.value}>
              {option.label}
            </option>
          ))}
        </TextField>
        <TextField
          label="AT&T Point of Contact first and last name"
          variant="outlined"
          fullWidth
          value={pocName}
          onChange={(e) => setPocName(e.target.value)}
          required
        />
        <TextField
          label="AT&T Point of Contact email address"
          type="email"
          variant="outlined"
          fullWidth
          value={pocEmail}
          onChange={(e) => setPocEmail(e.target.value)}
          required
        />

        <Typography variant="body2">
          By accessing these materials, data, and documents ("Content") contained herein,
          I hereby acknowledge and accept that they are the proprietary property of AT&T Services, Inc.
          or its affiliates. I understand and agree that any unauthorized modification, alteration,
          or revision of the Content is strictly prohibited without the express written consent of AT&T.
          I also acknowledge that any violation of these terms may be subject to legal action.
          I hereby express my understanding and willingness to comply with these terms.
          For permissions or inquiries, I understand that I should contact AT&T directly.
        </Typography>
        <FormControlLabel
          control={
            <Checkbox
              checked={termsOfService}
              onChange={(e) => setTermsOfService(e.target.checked)}
              required
            />
          }
          label="I accept these Terms and Conditions"
        />

        <Recaptcha
          key={recaptchaKey}
          siteKey={recaptchaSiteKey}
          onChange={setRecaptchaToken}
        />

        <Button type="submit" variant="contained" color="primary" fullWidth sx={{ mt: 2 }}>
          Create Account
        </Button>
      </Grid>
    </Box>
  );
};

export default InvitationEdit;
