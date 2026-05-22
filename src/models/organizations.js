import db from './db.js'

// const getAllOrganizations = async() => {
//     const query = `
//         SELECT organization_id, name, description, contact_email, logo_filename
//       FROM public.organization;
//     `;

//     const result = await db.query(query);

//     return result.rows;
// }

const getAllOrganizations = async () => {
  try {
    const result = await db.query(`
      SELECT organization_id, name, description, contact_email, logo_filename
      FROM public.organization;
    `);

    return result.rows;
  } catch (err) {
    console.error("🔥 DB ERROR:", err);
    throw err;
  }
};

export {getAllOrganizations} 