const fs = require('fs');
const axios = require('axios');

// ✅ Configuration
const API_URL = 'http://localhost:1338/api/flashcards';
const OUTPUT_FILE = 'flashcards_backup.json';
const ADMIN_TOKEN='6538d1356589b1535b2c97bc0e76cbe58ffbcaa8087558527ee0b37af5cefa195795b37839fdd885c3cbe624d7e38298130cc787eebd43f60748cd20cab040885dd334b6c88b2201ae2793ad08164177aeadff42f2c13bde3500db72abd0cb477d78e3f2c5d6b8e7073c8021be966076ba288e91d211b9063ec657199fd5fce9';

const headers = {
  Authorization: `Bearer ${ADMIN_TOKEN}`,
  'Content-Type': 'application/json',
};

// 🔁 Query string for deep population
const populateQuery = {
  populate: {
    user_word: true,
    section: true,
    word: true,
    example_sentences: true,
    tags: true,
    verb_meta: true,
    audio: true,
  },
};

async function fetchAllFlashcards() {
  const allItems = [];
  let page = 1;
  const pageSize = 100;

  while (true) {
    try {
      const res = await axios.get(API_URL, {
        headers,
        params: {
          'pagination[page]': page,
          'pagination[pageSize]': pageSize,
          ...populateQuery,
        },
      });

      const data = res.data.data;
      const meta = res.data.meta.pagination;

      allItems.push(...data);

      if (page * pageSize >= meta.total) break;

      page++;
    } catch (err) {
      console.error(`❌ Error on page ${page}:`, err.response?.data || err.message);
      break;
    }
  }

  return allItems;
}

(async () => {
  console.log('🔄 Fetching flashcards with full details...');
  const flashcards = await fetchAllFlashcards();

  fs.writeFileSync(OUTPUT_FILE, JSON.stringify({ data: flashcards }, null, 2));
  console.log(`✅ Exported ${flashcards.length} flashcards to ${OUTPUT_FILE}`);
})();
