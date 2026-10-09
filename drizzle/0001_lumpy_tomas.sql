CREATE TABLE `activity` (
	`id` text PRIMARY KEY NOT NULL,
	`scope` text NOT NULL,
	`expense_id` text,
	`actor` text NOT NULL,
	`action` text NOT NULL,
	`before` text,
	`after` text,
	`created` text NOT NULL
);
--> statement-breakpoint
CREATE INDEX `activity_scope_created` ON `activity` (`scope`,`created`);--> statement-breakpoint
CREATE TABLE `comments` (
	`id` text PRIMARY KEY NOT NULL,
	`scope` text NOT NULL,
	`expense_id` text NOT NULL,
	`user_id` text NOT NULL,
	`actor` text NOT NULL,
	`body` text NOT NULL,
	`created` text NOT NULL
);
--> statement-breakpoint
CREATE INDEX `comment_scope_expense` ON `comments` (`scope`,`expense_id`);--> statement-breakpoint
CREATE TABLE `invitations` (
	`token_hash` text PRIMARY KEY NOT NULL,
	`group_id` text NOT NULL,
	`person_id` text NOT NULL,
	`expires` text NOT NULL,
	`used_by` text,
	`created` text NOT NULL
);
--> statement-breakpoint
CREATE TABLE `group_members` (
	`id` text PRIMARY KEY NOT NULL,
	`group_id` text NOT NULL,
	`user_id` text NOT NULL,
	`person_id` text NOT NULL,
	`role` text NOT NULL,
	`joined` text NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `member_group_user` ON `group_members` (`group_id`,`user_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `member_group_person` ON `group_members` (`group_id`,`person_id`);--> statement-breakpoint
CREATE INDEX `member_user` ON `group_members` (`user_id`);--> statement-breakpoint
CREATE TABLE `shared_groups` (
	`id` text PRIMARY KEY NOT NULL,
	`owner` text NOT NULL,
	`data` text NOT NULL,
	`revision` integer DEFAULT 0 NOT NULL,
	`last_write` text DEFAULT '' NOT NULL
);
--> statement-breakpoint
ALTER TABLE `ledgers` ADD `last_write` text DEFAULT '' NOT NULL;