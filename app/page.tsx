import { greet } from './actions';

export default function Page() {
  return (
    <form action={greet}>
      <input name="name" />
      <button type="submit">Send</button>
    </form>
  );
}
