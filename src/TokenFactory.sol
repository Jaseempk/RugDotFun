// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {TokenBoilerPlate} from "src/TokenBoilerPlate.sol";
import {BondingCurve} from "src/BondingCurve.sol";

/// @title TokenFactory
/// @notice Factory contract for deploying new tokens and their bonding curves
/// @dev Handles token deployment, initial supply allocation, and bonding curve setup
contract TokenFactory {
    /// @notice Custom errors for better gas efficiency and clarity
    error F__InvalidAllocationLength();
    error F__ZeroAddress();
    error F__EmptyName();
    error F__EmptySymbol();

    /// @notice Constants for token supply calculations
    /// @dev All values are scaled by DECIMALS (1e18)
    uint256 public constant DECIMALS = 1e18;
    uint256 public constant MAX_SUPPLY = 100_000_000_000 * DECIMALS;
    uint256 private constant INIT_SUPPLY = (MAX_SUPPLY * 10) / 100; // 10% of max supply
    uint256 private constant BONDINGCURVE_SUPPLY = (MAX_SUPPLY * 90) / 100; // 90% of max supply

    /// @notice Emitted when a new token and its bonding curve are created
    /// @param deployer Address of the token deployer
    /// @param name Token name
    /// @param symbol Token symbol
    /// @param tokenAddress Address of the deployed token contract
    /// @param bondingCurveAddress Address of the deployed bonding curve contract
    event TokenCreated(
        address indexed deployer,
        string name,
        string symbol,
        address indexed tokenAddress,
        address indexed bondingCurveAddress
    );

    /// @notice Initializes a new token with its bonding curve
    /// @param name Token name
    /// @param symbol Token symbol
    /// @param description Token description
    /// @param adminAddress Address of the bonding curve admin
    /// @param allocationAddys Array of addresses for initial token allocation
    /// @param allocationAmount Array of amounts for initial token allocation
    /// @return tokenAddress Address of the deployed token contract
    /// @return bondingCurveAddress Address of the deployed bonding curve contract
    function initialiseToken(
        string calldata name,
        string calldata symbol,
        string calldata description,
        address adminAddress,
        address[] calldata allocationAddys,
        uint256[] calldata allocationAmount
    )
        external
        payable
        returns (address tokenAddress, address bondingCurveAddress)
    {
        // Input validation
        if (bytes(name).length == 0) revert F__EmptyName();
        if (bytes(symbol).length == 0) revert F__EmptySymbol();
        if (allocationAddys.length != allocationAmount.length)
            revert F__InvalidAllocationLength();

        // Deploy token contract
        TokenBoilerPlate token = new TokenBoilerPlate(
            name,
            symbol,
            MAX_SUPPLY,
            allocationAddys,
            allocationAmount,
            address(this)
        );

        // Deploy bonding curve contract
        BondingCurve bondingCurve = new BondingCurve(
            name,
            symbol,
            description,
            address(token),
            msg.sender,
            adminAddress
        );

        // Setup token permissions and mint bonding curve supply
        token.tokenMint(address(bondingCurve), BONDINGCURVE_SUPPLY);

        // Emit creation event
        emit TokenCreated(
            msg.sender,
            name,
            symbol,
            address(token),
            address(bondingCurve)
        );

        return (address(token), address(bondingCurve));
    }
}
