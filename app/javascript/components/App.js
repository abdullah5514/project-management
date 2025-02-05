import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import ProjectList from "./ProjectList";

const App = () => {
  return (
    <Router>
      <Routes>
      <Route path="/" element={<ProjectList />} />
        {/* Add more routes here */}
      </Routes>
    </Router>
  );
};

export default App;
