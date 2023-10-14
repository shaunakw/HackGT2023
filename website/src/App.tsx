import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';
import { signInWithRedirect, signOut } from "firebase/auth";
import { auth, githubProvider } from "./firebase";
import Button from '@mui/material/Button';
import Box from '@mui/material/Box';

function App() {
  return (
    <Box 
      display="flex" 
      justifyContent="center" 
      alignItems="center" 
      minHeight="100vh" 
      flexDirection="column"
      gap={2}
    >
      <div>
        <Button variant="outlined" onClick={() => signInWithRedirect(auth, githubProvider)}>
          Sign in
        </Button>
        <Button variant="outlined" onClick={() => signOut(auth)}>Sign out</Button>
      </div>
    </Box>
  );
}

export default App;
