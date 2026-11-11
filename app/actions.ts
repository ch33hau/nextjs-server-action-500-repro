'use server';

// One server action is enough. Without any, Next.js skips the action handler.
export async function greet(formData: FormData) {
  console.log('greet', formData.get('name'));
}
