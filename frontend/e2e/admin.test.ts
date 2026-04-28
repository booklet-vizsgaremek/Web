import { expect, test, type Page } from '@playwright/test';

const BASE_URL = 'http://frontend.vm1.test';
const ADMIN_EMAIL = 'admin@admin.com';
const MANAGER_EMAIL = 'manager@manager.com';
const PASSWORD = 'root_p_ssW0rd';

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

async function signIn(page: Page, email: string) {
	await page.goto(`${BASE_URL}/sign-in?ref=signin`);
	await waitForAppReady(page);
	await page.getByLabel('Email address').fill(email);
	await page.getByLabel('Password').fill(PASSWORD);
	await page.getByRole('button', { name: 'Sign in' }).click();
	await expect(page).toHaveURL(`${BASE_URL}/dashboard`);
}

async function signInAsAdmin(page: Page) {
	await signIn(page, ADMIN_EMAIL);
}

async function openUsersAsAdmin(page: Page) {
	await signInAsAdmin(page);
	await page.goto(`${BASE_URL}/users`);
	await waitForAppReady(page);
}

test('admin can sign in and sees admin navigation', async ({ page }) => {
	await signInAsAdmin(page);

	await expect(page.getByRole('link', { name: 'Dashboard' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Sign out' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Sign in' })).not.toBeVisible();
});

test('admin dashboard shows the admin-only users action', async ({ page }) => {
	await signInAsAdmin(page);
	await waitForAppReady(page);

	await expect(page.getByRole('button', { name: 'Users' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Orders' })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Data management' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Books' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Authors' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Genres' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Publishers' })).toBeVisible();
});

test('manager cannot open admin users page', async ({ page }) => {
	await signIn(page, MANAGER_EMAIL);
	await page.goto(`${BASE_URL}/users`);
	await waitForAppReady(page);

	await expect(page.getByText('Access denied')).toBeVisible();
	await expect(page.getByRole('button', { name: 'Back' })).toBeVisible();
});

test('admin can open users management page', async ({ page }) => {
	await signInAsAdmin(page);

	await page.getByRole('button', { name: 'Users' }).click();
	await waitForAppReady(page);

	await expect(page).toHaveURL(`${BASE_URL}/users`);
	await expect(page.getByRole('heading', { name: 'Users' })).toBeVisible();
	await expect(page.getByText('Access denied')).not.toBeVisible();
});

test('admin users page shows filters and table controls', async ({ page }) => {
	await openUsersAsAdmin(page);

	await expect(page.getByRole('heading', { name: 'Users' })).toBeVisible();
	await expect(page.getByPlaceholder(/filter by name or email address/i)).toBeVisible();
	await expect(page.getByText('Filter by role')).toBeVisible();
	await expect(page.getByRole('button', { name: 'All roles' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Apply filters' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Clear filters' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Columns' })).toBeVisible();
});

test('admin users table shows expected columns and seeded users', async ({ page }) => {
	await openUsersAsAdmin(page);

	await expect(page.getByRole('button', { name: /name/i }).first()).toBeVisible();
	await expect(page.getByRole('button', { name: /email address/i }).first()).toBeVisible();
	await expect(page.getByRole('button', { name: /role/i }).first()).toBeVisible();
	await expect(page.getByRole('button', { name: /orders/i }).first()).toBeVisible();
	await expect(page.getByText(ADMIN_EMAIL).last()).toBeVisible();
	await expect(page.getByText(MANAGER_EMAIL).last()).toBeVisible();
});

test('admin can filter users by role', async ({ page }) => {
	await openUsersAsAdmin(page);

	await page.getByRole('button', { name: 'All roles' }).click();
	await page.getByText('Manager').last().click();
	await page.getByRole('button', { name: 'Apply filters' }).click();
	await waitForAppReady(page);

	await expect(page).toHaveURL(/\/users\?(?=.*page=1)(?=.*role=manager)/);
	await expect(page.getByText('Manager User').last()).toBeVisible();
	await expect(page.getByText(MANAGER_EMAIL).last()).toBeVisible();
});

test('admin can search users and clear filters', async ({ page }) => {
	await openUsersAsAdmin(page);

	await page.getByPlaceholder('Filter by name or email address').fill('nomatch@test.com');
	await page.getByRole('button', { name: 'Apply filters' }).click();
	await waitForAppReady(page);

	await expect(page.getByText('No users found.').last()).toBeVisible();
	await page.getByRole('button', { name: 'Clear filters' }).click();
	await waitForAppReady(page);

	await expect(page).toHaveURL(`${BASE_URL}/users`);
	await expect(page.getByText(ADMIN_EMAIL).last()).toBeVisible();
});

test('admin can open user action dialogs without changing data', async ({ page }) => {
	await openUsersAsAdmin(page);

	await page.getByRole('button', { name: 'Change role' }).first().click();
	await expect(page.getByRole('heading', { name: 'Change role' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Confirm' })).toBeVisible();
	await page.getByRole('button', { name: 'Cancel' }).click();

	await page.getByRole('button', { name: 'Delete user' }).first().click();
	await expect(page.getByRole('heading', { name: 'Delete user' })).toBeVisible();
	await expect(page.getByText(/this action cannot be undone/i)).toBeVisible();
	await expect(page.getByRole('button', { name: 'Confirm' })).toBeVisible();
});
