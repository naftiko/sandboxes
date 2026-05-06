import { Container, getContainer } from "@cloudflare/containers";

interface Env {
  MICROCKS: DurableObjectNamespace<MicrocksContainer>;
  MICROCKS_USER: string;
  MICROCKS_PASS: string;
}

export class MicrocksContainer extends Container<Env> {
  defaultPort = 8080;
  sleepAfter = "10m";

  // Override fetch to give the JVM more time to start (up to 90s)
  override async fetch(request: Request): Promise<Response> {
    await this.startAndWaitForPorts(8080, {
      portReadyTimeoutMS: 90000,
      waitInterval: 3000,
    });
    return super.containerFetch(request);
  }

  override async onStart(): Promise<void> {
    console.log("Microcks container is ready on port 8080.");
  }

  override onStop(): void {
    console.log("Microcks container stopped.");
  }

  override onError(error: unknown): void {
    console.error("Microcks container error:", error);
  }
}

function unauthorized(): Response {
  return new Response("Unauthorized", {
    status: 401,
    headers: { "WWW-Authenticate": 'Basic realm="Microcks"' },
  });
}

function checkBasicAuth(request: Request, env: Env): boolean {
  const auth = request.headers.get("Authorization");
  if (!auth || !auth.startsWith("Basic ")) {
    return false;
  }

  const decoded = atob(auth.slice(6));
  const [user, pass] = decoded.split(":");
  return user === env.MICROCKS_USER && pass === env.MICROCKS_PASS;
}

// Mock endpoints are public; everything else requires auth
const PUBLIC_PREFIXES = ["/rest/", "/soap/", "/graphql/", "/dynarest/"];

function isPublicPath(url: string): boolean {
  const path = new URL(url).pathname;
  return PUBLIC_PREFIXES.some((prefix) => path.startsWith(prefix));
}

export default {
  async fetch(request: Request, env: Env): Promise<Response> {
    if (!isPublicPath(request.url) && !checkBasicAuth(request, env)) {
      return unauthorized();
    }

    const container = getContainer(env.MICROCKS);
    return container.fetch(request);
  },
};
