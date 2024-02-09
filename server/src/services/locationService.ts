import axios from "axios";

const url = "http://localhost:3000"

const getNearbyCafes = async () => {
  const result = await axios.get(url);

  return result.data;
}

const locationService = {getNearbyCafes}

export default locationService;
