// Import any needed model functions
import { 
  getAllCategories,
  getCategoriesByProjectId,
  getProjectsByCategoryId,
  getCategoryById,
  updateCategoryAssignments,
  createCategory,
  updateCategory
} from '../models/categories.js';
import { getProjectDetails } from '../models/projects.js';
import { body, validationResult } from 'express-validator';

const categoryValidation = [
    body('name')
        .trim()
        .notEmpty().withMessage('Name is required')
        .isLength({ min: 3, max: 100 }).withMessage('Name must be between 3 and 100 characters'),
];

// Define any controller functions
const showCategoriesPage = async (req, res) => {
  const categories = await getAllCategories();
  const title = 'Categories';

  res.render('categories', { title, categories });
};

const showCategoryDetailsPage = async (req, res) => {
  const categoryId = req.params.id;
  const category = await getCategoryById(categoryId);
  const projects = await getProjectsByCategoryId(categoryId);
  const title = category.name;

  res.render('category', { title, category, projects });
};

const showAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;

    const projectDetails = await getProjectDetails(projectId);
    const categories = await getAllCategories();
    const assignedCategories = await getCategoriesByProjectId(projectId);

    const title = 'Assign Categories to Project';

    res.render('assign-categories', { title, projectId, projectDetails, categories, assignedCategories });
};

const processAssignCategoriesForm = async (req, res) => {
    const projectId = req.params.projectId;
    const selectedCategoryIds = req.body.categoryIds || [];
    
    // Ensure selectedCategoryIds is an array
    const categoryIdsArray = Array.isArray(selectedCategoryIds) ? selectedCategoryIds : [selectedCategoryIds];
    await updateCategoryAssignments(projectId, categoryIdsArray);
    req.flash('success', 'Categories updated successfully.');
    res.redirect(`/project/${projectId}`);
};

const showNewCategoryForm = async (req, res) => {
    const title = 'Add New Category';
    res.render('new-category', { title });
};

const processNewCategoryForm = async (req, res) => {
    // Check for validation errors
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        // Loop through validation errors and flash them
        errors.array().forEach((error) => {
            req.flash('error', error.msg);
        });

        // Redirect back to the new category form
        return res.redirect('/new-category');
    }

    // Extract form data from req.body
    const { name } = req.body;

    try {
        // Create the new category in the database
        const newCategoryId = await createCategory(name);

        req.flash('success', 'New category created successfully!');
        res.redirect(`/category/${newCategoryId}`);
    } catch (error) {
        console.error('Error creating new category:', error);
        req.flash('error', 'There was an error creating the category.');
        res.redirect('/new-category');
    }
};

const showEditCategoryForm = async (req, res) => {
    const categoryId = req.params.id;
    const category = await getCategoryById(categoryId);

    const title = 'Edit Category';
    res.render('edit-category', { title, category });
};

const processEditCategoryForm = async (req, res) => {
    // Check for validation errors
    const results = validationResult(req);
    if (!results.isEmpty()) {
        // Validation failed - loop through errors
        results.array().forEach((error) => {
            req.flash('error', error.msg);
        });

        // Redirect back to the edit category form
        return res.redirect('/edit-category/' + req.params.id);
    }

    const categoryId = req.params.id;
    const { name } = req.body;

    await updateCategory(name, categoryId);

    // Set a success flash message
    req.flash('success', 'Category updated successfully!');

    res.redirect(`/category/${categoryId}`);
};

// Export any controller functions
export { showCategoriesPage, showCategoryDetailsPage, showAssignCategoriesForm, processAssignCategoriesForm, showNewCategoryForm, processNewCategoryForm, showEditCategoryForm, processEditCategoryForm, categoryValidation };