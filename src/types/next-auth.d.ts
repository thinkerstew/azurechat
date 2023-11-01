import NextAuth, { DefaultSession } from "next-auth"

// https://next-auth.js.org/getting-started/typescript#module-augmentation

declare module "next-auth" {

    interface Session {
        user: {
            isAdmin: string
            roles: string[]
        } & DefaultSession["user"]
    }

    interface User {
        isAdmin: string
    }

}
