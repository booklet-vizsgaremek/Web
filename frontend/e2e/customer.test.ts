import { expect, test, type Page } from '@playwright/test';

const BASE_URL = 'http://frontend.vm1.test';
const CUSTOMER_EMAIL = 'customer@customer.com';
const CUSTOMER_PASSWORD = 'root_p_ssW0rd';

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

async function signInAsCustomer(page: Page) {
	await page.goto(`${BASE_URL}/sign-in?ref=signin`);
	await waitForAppReady(page);
	await page.getByLabel('Email address').fill(CUSTOMER_EMAIL);
	await page.getByLabel('Password').fill(CUSTOMER_PASSWORD);
	await page.getByRole('button', { name: 'Sign in' }).click();
	await expect(page).toHaveURL(`${BASE_URL}/`);
}

test('home page has expected h1', async ({ page }) => {
	await page.goto(BASE_URL);
	await waitForAppReady(page);
	await expect(page.getByText('Top 10 most purchased books')).toBeVisible();
});

test('home page has expected header', async ({ page }) => {
	await page.goto(BASE_URL);
	await waitForAppReady(page);
	await expect(page.locator('header')).toBeVisible();
});

test('home page has expected sign in button', async ({ page }) => {
	await page.goto(BASE_URL);
	await waitForAppReady(page);
	await expect(page.getByText('Sign in')).toBeVisible();
});

test('home page has expected book lookup button', async ({ page }) => {
	await page.goto(BASE_URL);
	await waitForAppReady(page);
	await expect(page.getByText('Book lookup')).toBeVisible();
});

test('customer can sign in and sees customer navigation', async ({ page }) => {
	await signInAsCustomer(page);

	await expect(page.getByRole('link', { name: 'Book lookup' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Customer User' })).toBeVisible();
	await expect(page.getByRole('link', { name: 'Sign in' })).not.toBeVisible();
});

test('customer profile shows account actions and forms', async ({ page }) => {
	await signInAsCustomer(page);
	await page.goto(`${BASE_URL}/profile`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Account' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Orders' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Wishlist' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Sign out' })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Change user data' })).toBeVisible();
	await expect(page.getByRole('heading', { name: 'Change password' })).toBeVisible();
	await expect(page.getByRole('button', { name: 'Delete account' })).toBeVisible();
});

test('customer can open their orders page', async ({ page }) => {
	await signInAsCustomer(page);
	await page.goto(`${BASE_URL}/orders`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Orders' })).toBeVisible();
	await expect(page.getByText('Access denied')).not.toBeVisible();
});

test('customer sees empty checkout state without cart items', async ({ page }) => {
	await signInAsCustomer(page);
	await page.evaluate(() => localStorage.removeItem('cart'));
	await page.goto(`${BASE_URL}/checkout`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Checkout' })).toBeVisible();
	await expect(page.getByText('The cart is empty')).toBeVisible();
	await expect(page.getByRole('button', { name: 'Back to home' })).toBeVisible();
});

test('customer can add a book to the cart and continue checkout', async ({ page }) => {
	await signInAsCustomer(page);
	await page.goto(BASE_URL);
	await waitForAppReady(page);

	await page
		.locator('div[data-slot="carousel-content"] button[data-tooltip-trigger]:first-child')
		.first()
		.click();
	await page.goto(`${BASE_URL}/checkout`);
	await waitForAppReady(page);

	await expect(page.getByRole('heading', { name: 'Checkout' })).toBeVisible();
	await expect(page.getByText('Please confirm your details')).toBeVisible();
	await expect(page.getByText(`Email address: ${CUSTOMER_EMAIL}`)).toBeVisible();
	await expect(page.getByRole('button', { name: 'Continue' }).first()).toBeEnabled();
});
