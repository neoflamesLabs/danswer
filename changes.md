# Documentation: UI Customization Changes in Wulo Application

## Overview
This document details the comprehensive changes made to customize the Wulo application's UI, including branding modifications, color scheme updates, and component restructuring.

## 1. Color Scheme Modifications

### Global CSS Variables (`globals.css`)
```css
@layer base {
  :root {
    /* Primary Brand Colors */
    --accent: #00bcd4;              /* Primary cyan accent */
    --accent-hover: #00acc1;        /* Darker cyan for hover states */
    
    /* Text Colors */
    --text-400: #00bcd4;           /* Secondary/accent text (cyan) */
    --text-600: #212121;           /* Primary text */
    --text-700: #424242;           /* Strong text */
    
    /* UI Element Colors */
    --user-bubble: #009eb3b2;      /* Semi-transparent cyan */
    --ai-bubble: #009eb3;          /* Solid cyan */
    
    /* Border Colors */
    --border: #00bcd4;             /* Primary cyan border */
    --border-light: #4dd0e1;       /* Light cyan border */
    --border-medium: #00acc1;      /* Medium cyan border */
```

### Tailwind Configuration (`tailwind.config.js`)
```javascript
colors: {
  // Interactive Elements
  accent: "var(--accent)",
  "accent-hover": "var(--accent-hover)",
  
  // Borders
  border: "var(--border)",
  "border-light": "var(--border-light)",
  
  // Text Colors
  "text-400": "var(--text-400)",
  "text-600": "var(--text-600)",
}
```

## 2. Logo and Branding Changes

### Component Structure Changes
1. **Original Issue**: Double logo rendering due to both `FixedLogo` and `LogoType` components.
2. **Solution**: Added control mechanism to prevent duplicate rendering.

### FixedLogo Component (`components/FixedLogo.tsx`)
```typescript
interface FixedLogoProps {
  backgroundToggled?: boolean;
  hideMainLogo?: boolean;  // New prop
}

export default function FixedLogo({
  backgroundToggled,
  hideMainLogo = false
}: FixedLogoProps) {
  // Component logic
}
```

### Logo Size Adjustments
```typescript
// Increased logo dimensions
<Logo height={48} width={48} />  // Previously 24x24
```

### Container Modifications
```jsx
<div className="max-w-[300px] mobile:hidden flex items-center gap-x-2 my-auto">
  {/* Increased from max-w-[200px] */}
</div>
```

## 3. Header Structure Updates

### FunctionalHeader Component (`components/header/FunctionalHeader.tsx`)
```typescript
export default function FunctionalHeader({
  // ... existing props
}) {
  return (
    <div className="left-0 bg-transparent sticky top-0 z-20 w-full relative flex">
      {/* Primary Logo Instance */}
      <LogoType
        assistantId={currentChatSession?.persona_id}
        page={page}
        toggleSidebar={toggleSidebar}
        handleNewChat={handleNewChat}
      />
      
      {/* Removed duplicate LogoType instance */}
      {/* Previously had a second invisible instance */}
    </div>
  );
}
```

## 4. Mobile Responsiveness Updates

### Mobile-Specific Styles
```css
/* Mobile Logo Container */
.mobile:flex {
  display: none;
}

@media (max-width: 767px) {
  .mobile\:flex {
    display: flex;
  }
}
```

### Responsive Logo Sizing
```javascript
// Mobile vs Desktop Logo Sizes
const mobileLogoSize = 32;  // New mobile-specific size
const desktopLogoSize = 48; // New desktop size
```

## 5. Brand Text Modifications

### HeaderTitle Component
```jsx
<HeaderTitle backgroundToggled={backgroundToggled}>
  {enterpriseSettings?.application_name || "Wulo"}
</HeaderTitle>
```

### "Powered By" Text Removal
```jsx
{/* Removed or conditionally rendered based on NEXT_PUBLIC_DO_NOT_USE_TOGGLE_OFF_DANSWER_POWERED */}
{!NEXT_PUBLIC_DO_NOT_USE_TOGGLE_OFF_DANSWER_POWERED && (
  <p className="text-xs text-subtle">Powered by Wulo</p>
)}
```

## Implementation Notes

### Dependencies
- Tailwind CSS
- Next.js
- React

### Required Environment Variables
```bash
NEXT_PUBLIC_DO_NOT_USE_TOGGLE_OFF_DANSWER_POWERED=true
```

### File Structure Changes
```
src/
├── components/
│   ├── header/
│   │   ├── LogoType.tsx      # Modified
│   │   └── HeaderTitle.tsx   # Modified
│   └── FixedLogo.tsx        # Modified
├── app/
│   └── globals.css          # Modified
└── tailwind.config.js       # Modified
```

## Migration Steps
1. Update `globals.css` with new color variables
2. Modify `tailwind.config.js` to use new color scheme
3. Update `FixedLogo` component with new props and logic
4. Remove duplicate logo instance from `FunctionalHeader`
5. Test responsive behavior across breakpoints

## Testing Checklist
- [ ] Verify logo appears correctly in desktop view
- [ ] Check mobile responsiveness
- [ ] Test color scheme consistency
- [ ] Verify no duplicate logos
- [ ] Test enterprise settings integration

## Known Issues
- Mobile menu requires additional styling adjustments
- Enterprise settings may override some branding

Would you like me to expand on any of these sections or provide additional documentation?