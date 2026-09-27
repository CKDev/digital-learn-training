import React, { useEffect, useRef } from "react";

const RECAPTCHA_SCRIPT_SRC = "https://www.google.com/recaptcha/api.js";

let recaptchaScriptPromise = null;

function loadRecaptchaScript() {
  if (window.grecaptcha && window.grecaptcha.render) {
    return Promise.resolve();
  }

  if (!recaptchaScriptPromise) {
    recaptchaScriptPromise = new Promise((resolve) => {
      const script = document.createElement("script");
      script.src = RECAPTCHA_SCRIPT_SRC;
      script.async = true;
      script.defer = true;
      script.onload = () => {
        const waitForGrecaptcha = () => {
          if (window.grecaptcha && window.grecaptcha.render) {
            resolve();
          } else {
            setTimeout(waitForGrecaptcha, 50);
          }
        };
        waitForGrecaptcha();
      };
      document.body.appendChild(script);
    });
  }

  return recaptchaScriptPromise;
}

// Renders the Google reCAPTCHA v2 checkbox widget and reports the resulting
// token via onChange. Pass a changing `key` prop from the parent to force a
// remount (and thus a fresh widget/token) after a failed submission.
const Recaptcha = ({ siteKey, onChange }) => {
  const containerRef = useRef(null);
  const widgetIdRef = useRef(null);

  useEffect(() => {
    let cancelled = false;

    loadRecaptchaScript().then(() => {
      if (cancelled || !containerRef.current || widgetIdRef.current !== null) {
        return;
      }

      widgetIdRef.current = window.grecaptcha.render(containerRef.current, {
        sitekey: siteKey,
        callback: onChange,
        "expired-callback": () => onChange(""),
      });
    });

    return () => {
      cancelled = true;
    };
  }, [siteKey]);

  return <div ref={containerRef} />;
};

export default Recaptcha;
