import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon, Arc, FancyBboxPatch, Rectangle

# Configure fonts
plt.rcParams['font.sans-serif'] = ['Helvetica', 'Arial', 'DejaVu Sans']
plt.rcParams['font.family'] = 'sans-serif'
plt.rcParams['mathtext.fontset'] = 'stixsans'

def scene_wave(x):
    """
    Quasi-harmonic contrast pattern with ~5 cycles across [-1, 1] and identifiable peaks.
    """
    omega = 5.0 * np.pi
    # Envelope modulation creates identifiable landmarks for visual tracking
    env = 0.82 + 0.18 * np.cos(0.9 * np.pi * x - 0.2)
    wave = env * np.sin(omega * x - 0.3) + 0.08 * np.cos(2 * omega * x)
    return wave

def draw_camera(ax, x_center, y_apex, color='#1e293b'):
    """Draw a clean, compact camera glyph at the optical apex."""
    # Lens element
    ax.plot([x_center - 0.14, x_center + 0.14], [y_apex - 0.03, y_apex - 0.03], 
            color='#0f172a', lw=2.8, zorder=7)
    # Camera body
    body_w = 0.44
    body_h = 0.26
    rect = FancyBboxPatch((x_center - body_w/2, y_apex - 0.03 - body_h), 
                          body_w, body_h, 
                          boxstyle="round,pad=0.02,rounding_size=0.05",
                          facecolor='#334155', edgecolor='#0f172a', lw=1.2, zorder=6)
    ax.add_patch(rect)
    # Optical node
    ax.plot(x_center, y_apex, marker='o', markersize=4.5, color='#0f172a', zorder=8)

def generate_figure(output_path):
    fig = plt.figure(figsize=(10.5, 7.0), dpi=300)
    fig.patch.set_facecolor('white')

    ax = fig.add_axes([0, 0, 1, 1])
    ax.set_xlim(0, 10.5)
    ax.set_ylim(0, 7.0)
    ax.axis('off')

    # Color palette
    c_dark = '#0f172a'
    c_slate = '#334155'
    c_muted = '#64748b'
    c_light_line = '#cbd5e1'
    c_fov_a = '#f1f5f9'
    c_fov_border_a = '#94a3b8'
    
    # Warm amber / gold for B (matches textbook reference: 'yellow shaded region')
    c_amber_fill = '#fef08a'      # soft warm yellow
    c_amber_border = '#ca8a04'    # amber-600
    c_amber_curve = '#b45309'     # amber-700
    c_amber_bg = '#fef9c3'        # amber-100 highlight

    # Horizontal geometry
    panel_w = 3.6
    x_mid_a = 2.45
    x_mid_b = 7.45
    
    # Vertical geometry
    y_scene_wave = 5.70
    y_scene_plane = 4.95
    y_cam_a = 2.25
    d_val = y_scene_plane - y_cam_a # 2.70
    y_cam_b = y_scene_plane - d_val / 2.0 # 3.60
    y_image_wave = 0.90

    n_pts = 600
    u = np.linspace(-1, 1, n_pts)
    wave_full = scene_wave(u)

    # -------------------------------------------------------------
    # Panel Labels: (A) and (B)
    # -------------------------------------------------------------
    ax.text(0.65, 6.55, "(A)", fontsize=22, fontweight='bold', color=c_dark, va='center')
    ax.text(5.65, 6.55, "(B)", fontsize=22, fontweight='bold', color=c_dark, va='center')

    # Center Row Titles
    ax.text(5.0, y_scene_wave, "Scene", fontsize=18, fontweight='bold', color=c_dark, ha='center', va='center')
    ax.text(5.0, y_image_wave, "Image", fontsize=18, fontweight='bold', color=c_dark, ha='center', va='center')

    # =============================================================
    # PANEL A
    # =============================================================
    # 1. Top Scene Wave
    x_scene_a = x_mid_a + (panel_w / 2.0) * u
    y_scene_plot_a = y_scene_wave + 0.45 * wave_full
    ax.plot(x_scene_a, y_scene_plot_a, color=c_slate, lw=2.4, solid_capstyle='round', zorder=4)

    # Scene plane line
    ax.plot([x_mid_a - panel_w/2, x_mid_a + panel_w/2], 
            [y_scene_plane, y_scene_plane], color=c_light_line, lw=1.2, ls='-', zorder=2)

    # Optical axis (centerline)
    ax.plot([x_mid_a, x_mid_a], [y_cam_a, y_scene_plane], 
            color='#cbd5e1', lw=1.0, ls=':', zorder=3)

    # 2. FOV Cone A
    fov_pts_a = [
        [x_mid_a, y_cam_a],
        [x_mid_a - panel_w/2, y_scene_plane],
        [x_mid_a + panel_w/2, y_scene_plane]
    ]
    poly_a = Polygon(fov_pts_a, closed=True, facecolor=c_fov_a, edgecolor=c_fov_border_a, lw=1.5, zorder=2)
    ax.add_patch(poly_a)

    # Angle theta arc
    angle_deg = np.degrees(2 * np.arctan((panel_w/2) / d_val))
    arc_a = Arc((x_mid_a, y_cam_a), 0.85, 0.85, angle=90, 
                theta1=-angle_deg/2, theta2=angle_deg/2, 
                color=c_dark, lw=1.6, zorder=5)
    ax.add_patch(arc_a)
    ax.text(x_mid_a, y_cam_a + 0.58, r"$\theta$", 
            ha='center', va='center', fontsize=16, fontweight='bold', color=c_dark, zorder=6)

    # Camera glyph
    draw_camera(ax, x_mid_a, y_cam_a)

    # Distance arrow d
    x_dim_a = x_mid_a + panel_w/2 + 0.45
    ax.annotate('', xy=(x_dim_a, y_scene_plane), xytext=(x_dim_a, y_cam_a),
                arrowprops=dict(arrowstyle='<->', color=c_dark, lw=1.6, mutation_scale=16),
                zorder=5)
    ax.plot([x_dim_a - 0.12, x_dim_a + 0.12], [y_scene_plane, y_scene_plane], color='#94a3b8', lw=1.4)
    ax.plot([x_dim_a - 0.12, x_dim_a + 0.12], [y_cam_a, y_cam_a], color='#94a3b8', lw=1.4)
    ax.text(x_dim_a + 0.22, (y_scene_plane + y_cam_a)/2, r"$d$", 
            ha='left', va='center', fontsize=18, fontweight='bold', color=c_dark)

    # 3. Rendered Image Wave A
    x_img_a = x_mid_a + (panel_w / 2.0) * u
    y_img_plot_a = y_image_wave + 0.45 * wave_full
    ax.plot(x_img_a, y_img_plot_a, color=c_slate, lw=2.4, solid_capstyle='round')

    # Sub-label for frequency
    ax.text(x_mid_a, y_image_wave - 0.65, r"Frequency $\approx f$", 
            ha='center', va='top', fontsize=13, fontweight='bold', color=c_dark)

    # =============================================================
    # PANEL B
    # =============================================================
    # 1. Top Scene Wave
    x_scene_b = x_mid_b + (panel_w / 2.0) * u
    y_scene_plot_b = y_scene_wave + 0.45 * wave_full
    
    mask_captured = np.abs(u) <= 0.5
    mask_left = u < -0.5
    mask_right = u > 0.5

    # Yellow highlight block spanning from scene plane up past the wave
    # Perfectly connects with the yellow FOV cone below!
    highlight_rect = Rectangle((x_mid_b - panel_w/4, y_scene_plane), 
                               panel_w/2, (y_scene_wave + 0.52) - y_scene_plane,
                               facecolor=c_amber_bg, edgecolor='none', zorder=1)
    ax.add_patch(highlight_rect)
    # Subtle dashed boundary on left and right of captured column
    ax.plot([x_mid_b - panel_w/4, x_mid_b - panel_w/4], 
            [y_scene_plane, y_scene_wave + 0.52], color=c_amber_border, lw=1.0, ls=':', zorder=2)
    ax.plot([x_mid_b + panel_w/4, x_mid_b + panel_w/4], 
            [y_scene_plane, y_scene_wave + 0.52], color=c_amber_border, lw=1.0, ls=':', zorder=2)

    # Muted outer parts of scene
    ax.plot(x_scene_b[mask_left], y_scene_plot_b[mask_left], 
            color='#94a3b8', lw=2.0, ls='--', solid_capstyle='round', zorder=3)
    ax.plot(x_scene_b[mask_right], y_scene_plot_b[mask_right], 
            color='#94a3b8', lw=2.0, ls='--', solid_capstyle='round', zorder=3)
    # Captured central part
    ax.plot(x_scene_b[mask_captured], y_scene_plot_b[mask_captured], 
            color=c_amber_curve, lw=2.8, solid_capstyle='round', zorder=4)

    # Scene plane line
    ax.plot([x_mid_b - panel_w/2, x_mid_b + panel_w/2], 
            [y_scene_plane, y_scene_plane], color=c_light_line, lw=1.2, ls='-', zorder=2)
    ax.plot([x_mid_b - panel_w/4, x_mid_b + panel_w/4], 
            [y_scene_plane, y_scene_plane], color=c_amber_border, lw=2.8, zorder=4)

    # Optical axis (centerline)
    ax.plot([x_mid_b, x_mid_b], [y_cam_b, y_scene_plane], 
            color='#ca8a04', lw=1.0, ls=':', zorder=3)

    # 2. FOV Cone B (Yellow shaded region)
    fov_pts_b = [
        [x_mid_b, y_cam_b],
        [x_mid_b - panel_w/4, y_scene_plane],
        [x_mid_b + panel_w/4, y_scene_plane]
    ]
    poly_b = Polygon(fov_pts_b, closed=True, facecolor=c_amber_fill, edgecolor=c_amber_border, lw=1.8, zorder=2)
    ax.add_patch(poly_b)

    # Angle theta arc (identical theta)
    arc_b = Arc((x_mid_b, y_cam_b), 0.85, 0.85, angle=90, 
                theta1=-angle_deg/2, theta2=angle_deg/2, 
                color=c_dark, lw=1.6, zorder=5)
    ax.add_patch(arc_b)
    ax.text(x_mid_b, y_cam_b + 0.58, r"$\theta$", 
            ha='center', va='center', fontsize=16, fontweight='bold', color=c_dark, zorder=6)

    # Camera glyph
    draw_camera(ax, x_mid_b, y_cam_b)

    # Distance arrow d/2
    x_dim_b = x_mid_b + panel_w/4 + 0.45
    ax.annotate('', xy=(x_dim_b, y_scene_plane), xytext=(x_dim_b, y_cam_b),
                arrowprops=dict(arrowstyle='<->', color=c_dark, lw=1.6, mutation_scale=16),
                zorder=5)
    ax.plot([x_dim_b - 0.12, x_dim_b + 0.12], [y_scene_plane, y_scene_plane], color='#94a3b8', lw=1.4)
    ax.plot([x_dim_b - 0.12, x_dim_b + 0.12], [y_cam_b, y_cam_b], color='#94a3b8', lw=1.4)
    ax.text(x_dim_b + 0.22, (y_scene_plane + y_cam_b)/2, r"$d/2$", 
            ha='left', va='center', fontsize=18, fontweight='bold', color=c_dark)

    # Dotted reference line down to d level
    ax.plot([x_dim_b, x_dim_b], [y_cam_b, y_cam_a], color='#cbd5e1', lw=1.4, ls=':')
    ax.plot([x_dim_b - 0.08, x_dim_b + 0.08], [y_cam_a, y_cam_a], color='#cbd5e1', lw=1.4)

    # 3. Rendered Image Wave B
    # Exact zoomed version: u_sensor in [-1, 1] maps to u_scene in [-0.5, 0.5]
    u_sensor = np.linspace(-1, 1, n_pts)
    wave_zoomed = scene_wave(u_sensor * 0.5)
    x_img_b = x_mid_b + (panel_w / 2.0) * u_sensor
    y_img_plot_b = y_image_wave + 0.45 * wave_zoomed
    ax.plot(x_img_b, y_img_plot_b, color=c_amber_curve, lw=2.8, solid_capstyle='round')

    # Sub-label for frequency
    ax.text(x_mid_b, y_image_wave - 0.65, r"Frequency $\approx f/2$", 
            ha='center', va='top', fontsize=13, fontweight='bold', color=c_amber_curve)

    plt.savefig(output_path, dpi=300, facecolor='white', bbox_inches='tight')
    plt.close()
    print(f"Final figure saved to {output_path}")

if __name__ == '__main__':
    generate_figure('/Users/wandell/.gemini/antigravity-ide/brain/c7e42699-8421-484f-b20d-edf4bade095e/scratch/one-over-f-new.png')
