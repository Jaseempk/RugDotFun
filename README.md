# Rug Token Factory and Bonding Curve

This repository contains a set of smart contracts inspired by **pump.fun**, designed to deploy ERC20 tokens with an associated bonding curve mechanism. The system enables seamless token creation, initial supply allocation, and bonding curve-based token purchases, all while leveraging the power of Uniswap V3 for liquidity provision.

---

## **Overview**

This project is a decentralized platform for launching tokens with an integrated bonding curve. Similar to **pump.fun**, it allows users to create tokens, allocate initial supply, and purchase tokens through a bonding curve. Once the bonding curve reaches a specific funding threshold, the token "graduates" to a Uniswap V3 pool, enabling decentralized trading.

### **Key Features**

- **Token Deployment**: Create ERC20 tokens with customizable names, symbols, and initial allocations.
- **Bonding Curve**: Purchase tokens through an exponential bonding curve, with prices increasing as supply grows.
- **Uniswap V3 Integration**: Automatically configure a Uniswap V3 pool once the bonding curve graduates.
- **Dynamic Pricing**: Fair and transparent token pricing based on supply and demand.
- **Gas Efficiency**: Optimized for low gas usage with custom errors and immutable variables.
- **Foundry Integration**: Built and tested using Foundry for a streamlined development experience.

---

## **Contracts Overview**

### **1. `TokenFactory`**

- **Purpose**: Deploys new ERC20 tokens and their associated bonding curves.
- **Key Features**:
  - Token deployment with customizable metadata (name, symbol, description).
  - Initial supply allocation (10% to specified addresses, 90% to the bonding curve).
  - Bonding curve deployment for price discovery and token distribution.
  - Event emission for off-chain tracking of deployments.

### **2. `BondingCurve`**

- **Purpose**: Implements an exponential bonding curve for token purchases and integrates with Uniswap V3 for liquidity provision.
- **Key Features**:
  - Exponential bonding curve formula for dynamic pricing.
  - Graduation mechanism: Once 24 ETH is raised, the bonding curve graduates and configures a Uniswap V3 pool.
  - Chainlink price feed integration for USD-based calculations.
  - Dynamic scaling factor to adjust pricing based on supply proximity to the cap.

### **3. `TokenBoilerPlate`**

- **Purpose**: Standard ERC20 token implementation with additional minting and burning functionality.
- **Key Features**:
  - Factory-only minting to prevent unauthorized inflation.
  - Burn functionality for deflationary mechanisms.
  - Initial token allocation during deployment.

---

## **How It Works**

### **1. Token Creation**

- A user deploys a new token using the `TokenFactory` contract.
- The token is created with a specified name, symbol, and initial allocations.
- 10% of the total supply is allocated to specified addresses, and 90% is allocated to the bonding curve.

### **2. Token Purchase**

- Users can purchase tokens from the bonding curve by sending ETH.
- The price of tokens increases as the supply grows, following an exponential bonding curve formula.

### **3. Graduation to Uniswap V3**

- Once the bonding curve raises 24 ETH, it "graduates" and configures a Uniswap V3 pool for the token.
- Liquidity is provided using the raised ETH and a portion of the token supply.

### **4. Decentralized Trading**

- After graduation, the token is tradable on Uniswap V3, enabling decentralized price discovery and liquidity provision.

---

## **Key Features**

### **Inspired by pump.fun**

- **Seamless Token Launch**: Easily create and launch tokens with minimal setup.
- **Bonding Curve Mechanism**: Fair and transparent token pricing based on supply and demand.
- **Graduation to AMM**: Transition from bonding curve to decentralized trading on Uniswap V3.

### **Advanced Features**

- **Dynamic Scaling**: Adjusts token pricing based on supply proximity to the cap.
- **Chainlink Integration**: Fetches ETH/USD prices for USD-based calculations.
- **Gas Optimization**: Uses custom errors and immutable variables for efficient gas usage.

---

## **Installation and Usage**

### **Prerequisites**

- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed.
- Ethereum wallet (e.g., MetaMask).

### **Steps**

1. Clone the repository:
   ```bash
   git clone https://github.com/Jaseempk/RugDotFun.git
   cd RugDotFun
   ```
