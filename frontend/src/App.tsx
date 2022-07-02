import init, { greet } from "@sno2wman/hello-wasm";
import React, { useEffect } from "react";

export const App: React.FC = () => {
  useEffect(() => {
    init();
  }, []);

  return (
    <>
      <p>Wow</p>
      <button type="button" onClick={() => greet("sno2wman")}>Greet</button>
    </>
  );
};
