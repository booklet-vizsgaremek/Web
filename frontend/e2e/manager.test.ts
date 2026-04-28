import { expect, test, type Page } from '@playwright/test';

const BASE_URL = 'http://frontend.vm1.test';
const MANAGER_EMAIL = 'manager@manager.com';
const MANAGER_PASSWORD = 'root_p_ssW0rd';

async function waitForAppReady(page: Page) {
	await page.waitForLoadState('networkidle');
}

test.beforeEach(async ({ context }) => {
	await context.addCookies([
		{
			name: 'PARAGLIDE_LANGUAGE',
			value: 'en',
			domain: 'http://frontend.vm1.test',
			path: '/'
		}
	]);
});

async function signInAsManager(page: Page) {
	await page.goto(`${BASE_URL}/sign-in?ref=signin`);
	await waitForAppReady(page);
	await page.getByLabel('Email address').fill(MANAGER_EMAIL);
	await page.getByLabel('Password').fill(MANAGER_PASSWORD);
	await page.getByRole('button', { name: 'Sign in' }).click();
	await expect(page).toHaveURL(`${BASE_URL}/dashboard`);
}

test('manager can sign in and sees dashboard navigation', async ({ page }) => {
	await signInAsManager(page);

	await expect(page.getByRole('link', { name: 'Dashboard' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Sign out' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Sign in' })).not.toBeVisible();
});

test('manager dashboard shows management actions without admin-only users action', async ({ page }) => {
	await signInAsManager(page);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: /manager/i })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Management' }).first()).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Data management' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Orders' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Coupons and discounts' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Books' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Authors' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Genres' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Publishers' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Users' })).toHaveCount(0);
});

test('manager can open authors management page', async ({ page }) => {
	await signInAsManager(page);
	await page.goto(`${BASE_URL}/authors`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Authors' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'New author' })).toBeVisible();
	await expect(page.getByPlaceholder(/search/i)).toBeVisible();
	await expect(page.getByText('No results.')).not.toBeVisible();
});

test('manager can open genres management and create dialog', async ({ page }) => {
	await signInAsManager(page);
	await page.goto(`${BASE_URL}/genres`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Genres' })).toBeVisible();
	await page.getByRole('button', { name: 'New genre' }).click();

	
	await expect(page.getByLabel('Name in Hungarian')).toBeVisible();
	await expect(page.getByLabel('Name in English')).toBeVisible();
	await expect(page.getByRole('button', { name: 'Save' })).toBeVisible();
});

test('manager can open publishers management and create dialog', async ({ page }) => {
	await signInAsManager(page);
	await page.goto(`${BASE_URL}/publishers`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Publishers' })).toBeVisible();
	await page.getByRole('button', { name: 'New publisher' }).click();

	//await expect(page.getByRole('dialog')).toBeVisible();
	await expect(page.getByLabel('Name')).toBeVisible();
	await expect(page.getByRole('button', { name: 'Save' })).toBeVisible();
});

test('manager can open staff orders page and sees filtering tools', async ({ page }) => {
	await signInAsManager(page);
	await page.goto(`${BASE_URL}/staff/orders`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Orders' })).toBeVisible();
	await expect(page.getByPlaceholder(/search by name or email address/i)).toBeVisible();
	await expect(page.getByRole('button', { name: 'Show all orders' })).toBeVisible();
	await expect(page.getByText(/order #/i).first()).toBeVisible();
});

test('manager can open an order details page', async ({ page }) => {
	await signInAsManager(page);
	await page.goto(`${BASE_URL}/staff/orders`);
	await waitForAppReady(page);

	await page.getByRole('link', { name: /order #/i }).first().click();
	await waitForAppReady(page);

	await expect(page).toHaveURL(/\/staff\/orders\/.+$/);
	await expect(page.getByRole('heading', { name: /order #/i })).toBeVisible();
	await expect(page.getByText('Customer:')).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Update status' })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Items' })).toBeVisible();
});

test('manager can open books management page', async ({ page }) => {
	await signInAsManager(page);
	await page.goto(`${BASE_URL}/books`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Book lookup' })).toBeVisible();
	await expect(page.getByPlaceholder(/filter by title/i)).toBeVisible();
	await expect(page.getByRole('button', { name: 'Apply filters' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Clear filters' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Add new book' })).toBeVisible();
});

test('manager can open new book form', async ({ page }) => {
	await signInAsManager(page);
	await page.goto(`${BASE_URL}/books/new`);
	await waitForAppReady(page);

	await expect(page.getByLabel('Title')).toBeVisible();
	await expect(page.getByLabel('Price')).toBeVisible();
	await expect(page.getByLabel('Release year')).toBeVisible();
	await expect(page.getByLabel('Pages')).toBeVisible();
	await expect(page.getByText('Publisher', {exact: true})).toBeVisible();
	await expect(page.getByText('Genre', {exact: true})).toBeVisible();
	await expect(page.getByText('Author(s)', {exact: true})).toBeVisible();
	await expect(page.getByLabel('Stock')).toBeVisible();
	await expect(page.getByRole('button', { name: 'Create' })).toBeVisible();
});
