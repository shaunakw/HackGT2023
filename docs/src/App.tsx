import { useEffect, useState } from "react";
import * as db from "./db";

function App() {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    db.init().then(() => {
      setLoading(false);
    });
  }, []);

  return (
    <div>
      <p>Hello</p>
      <p>{loading ? "Loading" : "Not loading"}</p>
    </div>
  );
}

export default App;
