import { createRequire } from "module";
const require = createRequire(import.meta.url);

export const APP_VERSION: string = require("../package.json").version;