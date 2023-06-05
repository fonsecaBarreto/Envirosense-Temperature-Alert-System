
function csvStringToJson(csvString) {
  const lines = csvString.split('\n');
  const headers = lines[0].split(',');

  const result = [];

  for (let i = 1; i < lines.length; i++) {
    const currentLine = lines[i].split(',');
    if (currentLine.length === headers.length) {
      const obj = {};
      for (let j = 0; j < headers.length; j++) {
        obj[headers[j]] = currentLine[j];
      }
      result.push(obj);
    }
  }

  return JSON.stringify(result, null, 4);
}

module.exports = { csvStringToJson };