import { expect, test, type Page } from '@playwright/test';

const BASE_URL = 'http://frontend.vm1.test';
const STAFF_EMAIL = 'staff@staff.com';
const STAFF_PASSWORD = 'root_p_ssW0rd';

async function waitForAppReady(page: Page) {
	await page.waitForLoadState('networkidle');
}

test.beforeEach(async ({ context }) => {
	await context.addCookies([
		{
			name: 'PARAGLIDE_LANGUAGE',
			value: 'en',
			domain: BASE_URL,
			path: '/'
		}
	]);
});

async function signInAsStaff(page: Page) {
	await page.goto(`${BASE_URL}/sign-in?ref=signin`);
	await waitForAppReady(page);
	await page.getByLabel('Email address').fill(STAFF_EMAIL);
	await page.getByLabel('Password').fill(STAFF_PASSWORD);
	await page.getByRole('button', { name: 'Sign in' }).click();
	await expect(page).toHaveURL(`${BASE_URL}/dashboard`);
}

test('staff can sign in and sees staff navigation', async ({ page }) => {
	await signInAsStaff(page);

	await expect(page.getByRole('link', { name: 'Dashboard' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Sign out' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Sign in' })).not.toBeVisible();
});

test('staff dashboard shows only staff management actions', async ({ page }) => {
	await signInAsStaff(page);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: /staff/i })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Management' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Orders' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Users' })).toHaveCount(0);
	await expect(page.getByRole('button', { name: 'Coupons and discounts' })).toHaveCount(0);
	await expect(page.getByRole('heading', { name: 'Data management' })).toHaveCount(0);
});

test('staff page shows orders and book lookup actions', async ({ page }) => {
	await signInAsStaff(page);
	await page.goto(`${BASE_URL}/staff`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: /staff/i })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Management' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Orders' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Book lookup' })).toBeVisible();
});

test('staff can navigate from staff page to orders', async ({ page }) => {
	await signInAsStaff(page);
	await page.goto(`${BASE_URL}/staff`);
	await waitForAppReady(page);

	await page.getByRole('button', { name: 'Orders' }).click();
	await waitForAppReady(page);

	await expect(page).toHaveURL(`${BASE_URL}/staff/orders`);
	await expect(page.getByRole('heading', { name: 'Orders' })).toBeVisible();
});

test('staff can navigate from staff page to book lookup', async ({ page }) => {
	await signInAsStaff(page);
	await page.goto(`${BASE_URL}/staff`);
	await waitForAppReady(page);

	await page.getByRole('button', { name: 'Book lookup' }).click();
	await waitForAppReady(page);

	await expect(page).toHaveURL(`${BASE_URL}/books`);
	await expect(page.getByRole('heading', { name: 'Book lookup' })).toBeVisible();
	await expect(page.getByPlaceholder(/filter by title/i)).toBeVisible();
});

test('staff orders page shows search, status filter and orders', async ({ page }) => {
	await signInAsStaff(page);
	await page.goto(`${BASE_URL}/staff/orders`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Orders' })).toBeVisible();
	await expect(page.getByPlaceholder(/search by name or email address/i)).toBeVisible();
	await expect(page.getByRole('button', { name: 'Show all orders' })).toBeVisible();
	await expect(page.getByRole('link', { name: /order #/i }).first()).toBeVisible();
});

test('staff can filter orders to an empty state and clear filters', async ({ page }) => {
	await signInAsStaff(page);
	await page.goto(`${BASE_URL}/staff/orders`);
	await waitForAppReady(page);

	await page
		.getByPlaceholder(/search by name or email address/i)
		.fill('no-user-matches-this-search');

	await expect(
		page.getByText("There aren't any orders yet with the currently selected filter/search")
	).toBeVisible();
	await page.getByRole('button', { name: 'Clear filters' }).click();
	await waitForAppReady(page);

	await expect(page.getByRole('link', { name: /order #/i }).first()).toBeVisible();
});

test('staff orders status filter lists every status', async ({ page }) => {
	await signInAsStaff(page);
	await page.goto(`${BASE_URL}/staff/orders`);
	await waitForAppReady(page);

	await page.getByRole('button', { name: 'Show all orders' }).click();

	await expect(page.getByText('Pending').first()).toBeVisible();
	await expect(page.getByText('Ready for pickup').first()).toBeVisible();
	await expect(page.getByText('Completed').first()).toBeVisible();
	await expect(page.getByText('Cancelled').first()).toBeVisible();
});

test('staff can open an order details page', async ({ page }) => {
	await signInAsStaff(page);
	await page.goto(`${BASE_URL}/staff/orders`);
	await waitForAppReady(page);

	await page
		.getByRole('link', { name: /order #/i })
		.first()
		.click();
	await waitForAppReady(page);

	await expect(page).toHaveURL(/\/staff\/orders\/.+$/);
	await expect(page.getByRole('heading', { name: /order #/i })).toBeVisible();
	await expect(page.getByText('Customer:')).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Update status' })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Items' })).toBeVisible();
});
