# Provider Architecture

## Organization
- `lib/core/providers/`: Holds app-wide state (e.g. locale, theme mode, `activeFarmerProfileProvider`, `onboardingStateProvider`).
- `lib/features/<feature>/providers/`: Holds state scoped to one feature only.

## Golden Rules
1. **No Sideways Access**: A provider never reaches sideways into another feature's provider file directly. If a feature needs data from another feature, that shared state belongs in `core`.
2. **Naming Convention**: 
   - `xProvider` for simple values or repositories (e.g., `yieldRepositoryProvider`).
   - `xNotifierProvider` for StateNotifier-backed mutable state (e.g., `onboardingStateProvider`).
3. **Overridability**: Every provider must be trivially overridable in tests via `ProviderScope.overrides`. Never use global singletons or static fields to bypass this pattern.
